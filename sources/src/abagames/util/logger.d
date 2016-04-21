/*
 * $Id: logger.d,v 1.3 2004/05/14 14:35:38 kenta Exp $
 *
 * Copyright 2003 Kenta Cho. All rights reserved.
 */
module abagames.util.logger;

private import std.stdio;
private import std.conv;

/**
 * Logger(error/info).
 */
version(Win32_release) {

import std.string;
import std.c.windows.windows;

public class Logger {

  public static void info(const char[] msg) {
    // Win32 exe file crashes if it writes something to stderr.
    //stderr.writeln("Info: " ~ msg);
  }

  public static void info(int n) {
    //stderr.writeln("Info: " ~ to!string(n));
  }

  public static void info(float n) {
    //stderr.writeln("Info: -" ~ to!string(n));
  }

  private static void putMessage(const char[] msg) {
    MessageBoxA(null, std.string.toStringz(msg), "Error", MB_OK | MB_ICONEXCLAMATION);
  }

  public static void error(const char[] msg) {
    putMessage("Error: " ~ msg);
  }

  public static void error(Exception e) {
    putMessage("Error: " ~ e.toString());
  }

  public static void error(Error e) {
    putMessage("Error: " ~ e.toString());
  }
}

} else {

public class Logger {

  public static void info(const char[] msg) {
    stderr.writeln("Info: " ~ msg);
  }

  public static void info(int n) {
    stderr.writeln("Info: " ~ to!string(n));
  }

  public static void info(float n) {
    stderr.writeln("Info: -" ~ to!string(n));
  }

  public static void error(const char[] msg) {
    stderr.writeln("Error: " ~ msg);
  }

  public static void error(Exception e) {
    stderr.writeln("Error: " ~ e.toString());
  }

  public static void error(Error e) {
    stderr.writeln("Error: " ~ e.toString());
    if (e.next)
      error(cast(Error)e.next);
  }
}

}
