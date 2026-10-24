unit untAjudaCampos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.StdCtrls, MemoFocus,
  Vcl.ComCtrls, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Uni, System.StrUtils, System.UITypes;

type
  TfrmAjudaCampos = class(TfrmPaiEdit)
    pgcInfo: TPageControl;
    procedure FormCreate(Sender: TObject);
  private
    function StrToFont(strFont: string): TFont;
    procedure pAdicionaFim(strRecuo, strFim: string);
    procedure pAdicionaInicio(strRecuo, strInicio: string);
    { Private declarations }
  public
    mmfMemo: TMemoFocus;
    { Public declarations }
  end;

var
  frmAjudaCampos: TfrmAjudaCampos;

implementation

uses
  untFuncoesSimples;

const
  CSFSBOLD      = '|fsBold';
  CSFSITALIC    = '|fsItalic';
  CSFSUNDERLINE = '|fsUnderline';
  CSFSSTRIKEOUT = '|fsStrikeOut';

{$R *.dfm}

function TfrmAjudaCampos.StrToFont(strFont: string): TFont;
var
  intPosition: Integer;
  strStyle: string;
begin
  Result := TFont.Create;

  intPosition := Pos(',', strFont);
  Result.Name := Copy(strFont, 1, intPosition - 1);
  Delete(strFont, 1, intPosition);
  intPosition := Pos(',', strFont);
  Result.Size := StrToInt(Copy(strFont, 2, intPosition - 2));
  Delete(strFont, 1, intPosition);
  intPosition := Pos(',', strFont);
  strStyle := '|' + Copy(strFont, 3, intPosition - 4);
  Delete(strFont, 1, intPosition);
  Result.Color := StringToColor(Copy(strFont, 2, Length(strFont)));
  Result.Style := [];
  if(Pos(CSFSBOLD, strStyle ) > 0) then
    Result.Style := Result.Style + [fsBold];
  if(Pos(CSFSITALIC, strStyle) > 0) then
    Result.Style := Result.Style + [fsItalic];
  if(Pos(CSFSUNDERLINE, strStyle) > 0) then
    Result.Style := Result.Style + [fsUnderline];
  if(Pos(CSFSSTRIKEOUT, strStyle) > 0) then
    Result.Style := Result.Style + [fsStrikeout];
end;

procedure TfrmAjudaCampos.pAdicionaInicio(strRecuo, strInicio: string);
begin
  mmfMemo.Lines.Add('');
  mmfMemo.Lines.Add('');
  mmfMemo.Lines.Add(strRecuo + strInicio);
  mmfMemo.Lines.Add('');
end;

procedure TfrmAjudaCampos.pAdicionaFim(strRecuo, strFim: string);
begin
  mmfMemo.Lines.Add(strRecuo + strFim);
  mmfMemo.Lines.Add('');
  mmfMemo.Lines.Add('');
  mmfMemo.ReadOnly := True;
end;

procedure TfrmAjudaCampos.FormCreate(Sender: TObject);
var
  qryConsulta: TUniQuery;
  intAba: Integer;
  tbsSheet: TTabSheet;
  strInicio, strFim, strRecuo: string;
  blnTemRegistro: Boolean;

begin
  inherited;

  // setar variáveis antes de começar
  strRecuo := '   ';
  intAba := 0;
  blnTemRegistro := False;

  strInicio := 'Constantes/funcões/comandos disponíveis para utilização no título do campo';
  strFim := 'Todos as constantes/funções/comandos devem ser escritas de forma idêntica como está acima, em letras maiúsculas.';

  try
    qryConsulta := fCriaQuery;
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM AJUREL WHERE REL_TIPAJU = "CAMPOS" ORDER BY REL_NUMABA, REL_CODAJU');
    qryConsulta.Open;
    while not qryConsulta.Eof do
    begin
      blnTemRegistro := True;
      if intAba <> qryConsulta.FieldByName('REL_NUMABA').AsInteger then
      begin
        if intAba <> 0 then
          pAdicionaFim(strRecuo, strFim);
        intAba := qryConsulta.FieldByName('REL_NUMABA').AsInteger;
        tbsSheet := TTabSheet.Create(pgcInfo);
        tbsSheet.Name := 'tbsCampos' + qryConsulta.FieldByName('REL_NUMABA').AsString;
        tbsSheet.Caption := qryConsulta.FieldByName('REL_NUMABA').AsString + ' - ' + qryConsulta.FieldByName('REL_DESABA').AsString;
        tbsSheet.PageControl := pgcInfo;
        mmfMemo := TMemoFocus.Create(Self);
        mmfMemo.Parent := tbsSheet;
        mmfMemo.Name := 'mmfCampos' + qryConsulta.FieldByName('REL_NUMABA').AsString;
        mmfMemo.Align := alClient;
        mmfMemo.Color := clInfoBk;
        mmfMemo.ScrollBars := ssVertical;
        mmfMemo.Font := StrToFont(IfThen(qryConsulta.FieldByName('REL_PREABA').AsString = 'S', 'Courier New', 'Arial') + ', 8, [fsBold], 000000');
        mmfMemo.Lines.Clear;
        pAdicionaInicio(strRecuo, strInicio);
      end;
      mmfMemo.Lines.Add(strRecuo + qryConsulta.FieldByName('REL_DESCRI').AsString + ': ' + AnsiReplaceStr(qryConsulta.FieldByName('REL_TXTAJU').AsString, '<<csq>>', #13#10));
      mmfMemo.Lines.Add('');
      qryConsulta.Next;
    end;
    if blnTemRegistro then
    begin
      pAdicionaFim(strRecuo, strFim);
      pgcInfo.ActivePageIndex := 0;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;


end;

end.
