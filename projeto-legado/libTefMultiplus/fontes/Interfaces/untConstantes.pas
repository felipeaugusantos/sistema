unit untConstantes;

interface

Uses SysUtils, {$IFDEF VER180}
                 Messages
               {$ELSE}
                 Winapi.Messages
               {$ENDIF}
               ;

  Type
    ExceptionAutCom = Class(Exception);

  Const
    ERROR_FOREIGN_KEY_DELETE = 1217;
    ERROR_FOREIGN_KEY_INSERT = 1216;
    ERROR_PRIMARY_KEY_INSERT = 1062;
    CM_AVISOS = WM_USER + 1;

implementation

end.
