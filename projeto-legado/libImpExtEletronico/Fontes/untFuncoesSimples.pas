unit untFuncoesSimples;

interface

uses
  ShareMem, Winapi.Messages, System.SysUtils,  System.Types,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdComponent, IdUri,
  EditFocus, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.OleCtrls, DateUtils,
  Vcl.Menus, SHDocVw, MSHTML, wininet, System.UiTypes,
  IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdCookieManager,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Vcl.Controls, System.Classes, Vcl.Buttons, Registry, Winapi.Windows,
  untGravandoObs, untSubjectIntf, untSubjectClass, Vcl.AppEvnts, cxGraphics;

  procedure pApagarIECache;
  function fAsciiToInt(Caracter: Char): Integer;
  function fCriptografa(texto:string;chave:integer):String;
  function fDesCriptografa(texto:string;chave:integer):String;

implementation

uses untGravando;

procedure pApagarIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;

  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

  GetMem(lpEntryInfo, dwEntrySize);

  if dwEntrySize>0 then
    lpEntryInfo^.dwStructSize := dwEntrySize;

  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);

  if hCacheDir<>0 then
  begin
    repeat
      Application.ProcessMessages;

      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
      FreeMem(lpEntryInfo, dwEntrySize);
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      GetMem(lpEntryInfo, dwEntrySize);
      if dwEntrySize>0 then
        lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);

  end;
  FreeMem(lpEntryInfo, dwEntrySize);

  FindCloseUrlCache(hCacheDir)
end;

function fAsciiToInt(Caracter: Char): Integer;
var
  i: Integer;
begin
  i := 32;
  while i < 255 do begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

function fCriptografa(texto:string;chave:integer):String;
var
  cont:integer;
  retorno:string;
begin
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(fasciitoint(texto[cont])+chave);
    end;
    result:=retorno;
  end;
end;

function fDesCriptografa(texto:string;chave:integer):String;
var
  cont:integer;
  retorno:string;
begin
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(fasciitoint(texto[cont])-chave);
    end;
    result:=retorno;
  end;
end;


end.
