#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <signal.h>

#define GB "\033[42m \033[0m"   /* green block, 1 visible char */
#define XX " "                   /* blank,      1 visible char */
#define SLOT 7                   /* each element occupies 7 columns */

static const int font[10][5][5] = {
    /* 0 */ {{1,1,1,1,1},{1,0,0,0,1},{1,0,0,0,1},{1,0,0,0,1},{1,1,1,1,1}},
    /* 1 */ {{0,0,1,0,0},{0,1,1,0,0},{0,0,1,0,0},{0,0,1,0,0},{1,1,1,1,1}},
    /* 2 */ {{1,1,1,1,1},{0,0,0,0,1},{1,1,1,1,1},{1,0,0,0,0},{1,1,1,1,1}},
    /* 3 */ {{1,1,1,1,1},{0,0,0,0,1},{1,1,1,1,1},{0,0,0,0,1},{1,1,1,1,1}},
    /* 4 */ {{1,0,0,0,1},{1,0,0,0,1},{1,1,1,1,1},{0,0,0,0,1},{0,0,0,0,1}},
    /* 5 */ {{1,1,1,1,1},{1,0,0,0,0},{1,1,1,1,1},{0,0,0,0,1},{1,1,1,1,1}},
    /* 6 */ {{1,1,1,1,1},{1,0,0,0,0},{1,1,1,1,1},{1,0,0,0,1},{1,1,1,1,1}},
    /* 7 */ {{1,1,1,1,1},{0,0,0,0,1},{0,0,0,1,0},{0,0,1,0,0},{0,1,0,0,0}},
    /* 8 */ {{1,1,1,1,1},{1,0,0,0,1},{1,1,1,1,1},{1,0,0,0,1},{1,1,1,1,1}},
    /* 9 */ {{1,1,1,1,1},{1,0,0,0,1},{1,1,1,1,1},{0,0,0,0,1},{1,1,1,1,1}},
};

static void cell(int on)  { printf("%s", on ? GB : XX); }
static void at(int r, int c) { printf("\033[%d;%dH", r, c); }

static void digit(int d, int br, int bc) {
    for (int r = 0; r < 5; r++) {
        at(br + r, bc);
        for (int c = 0; c < 5; c++) cell(font[d][r][c]);
        printf("  ");   /* trailing gap */
    }
}

static void dot(int br, int bc) {
    for (int r = 0; r < 5; r++) {
        at(br + r, bc);
        /* original juhao: add bx,4*160  — two adjacent dots at bottom */
        if (r == 4) printf(" \033[42m  \033[0m    ");
        else        printf("%*s", SLOT, "");
    }
}

static void colon(int br, int bc) {
    for (int r = 0; r < 5; r++) {
        at(br + r, bc);
        /* original maohao: row+1 and row+3, two adjacent dots at col+1 */
        if (r == 1 || r == 3) printf(" \033[42m  \033[0m    ");
        else                  printf("%*s", SLOT, "");
    }
}

static void two(int n, int br, int bc) {
    digit(n / 10, br, bc);
    digit(n % 10, br, bc + SLOT);
}

static void cleanup(void) {
    printf("\033[?25h\033[2J\033[H");
    fflush(stdout);
}

static void sig_handler(int sig) { (void)sig; cleanup(); exit(0); }

int main(void) {
    signal(SIGINT,  sig_handler);
    signal(SIGTERM, sig_handler);
    atexit(cleanup);

    printf("\033[?25l\033[2J");   /* hide cursor, clear once at startup */

    for (;;) {
        time_t now = time(NULL);
        struct tm *t = localtime(&now);
        int year = t->tm_year + 1900;

        int dr = 2;   /* date base row */
        int tr = 9;   /* time base row */
        int c0 = 5;   /* left margin */

        /* Date: YYYY.MM.DD */
        two(year / 100,        dr, c0 + SLOT*0);
        two(year % 100,        dr, c0 + SLOT*2);
        dot(                   dr, c0 + SLOT*4);
        two(t->tm_mon + 1,     dr, c0 + SLOT*5);
        dot(                   dr, c0 + SLOT*7);
        two(t->tm_mday,        dr, c0 + SLOT*8);

        /* Time: HH:MM:SS */
        two(t->tm_hour, tr, c0);
        colon(           tr, c0 + SLOT*2);
        two(t->tm_min,   tr, c0 + SLOT*3);
        colon(           tr, c0 + SLOT*5);
        two(t->tm_sec,   tr, c0 + SLOT*6);

        fflush(stdout);
        usleep(100000);
    }
}
