unit untPaiTransfCod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmPaiTransfCod = class(TfrmPai)
  private
    { Private declarations }
  protected
    procedure DoShow;override;
  public
    { Public declarations }
    class function fEstaEmPeriodoRestricaoDeTransferenciaCodigo: Boolean;
  end;

var
  frmPaiTransfCod: TfrmPaiTransfCod;

implementation

uses
  DateUtils,
  untFuncoesSimples;

{$R *.dfm}

{ TfrmPaiTransfCod }

procedure TfrmPaiTransfCod.DoShow;
begin
  if fEstaEmPeriodoRestricaoDeTransferenciaCodigo then
  begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0); //fechando o formulário
  end
  else
    inherited;
end;

class function TfrmPaiTransfCod.fEstaEmPeriodoRestricaoDeTransferenciaCodigo: Boolean;
Var
  ldtaAux: TDateTime;
  lHrInicial,
  lHrFinal,
  lNow: TDateTime;
  lstrAux,
  lstrPeriodo: String;
  lDia, lMes, lAno, lHora, lMin, lSeg, lMilSeg: Word;
begin
  Result := False;
  lstrPeriodo := fCfgSis('HRTCOD', varString);
  lstrPeriodo := Trim(lstrPeriodo);

{$Region 'Validação inicial do dado preenchido no banco'}
{formarto esperado: "hh:mm|hh:mm".
 caso o valor no banco não atenda ao formato desejato, não há como validar.
 Portanto, para evitar restrição indevida e/ou falha na verificação,
 é forçada a saída da função com valor falso.}
  if fEmptyStr(lstrPeriodo) then
    Exit;

  If (length(lstrPeriodo) <> 11) or (pos('|', lstrPeriodo) <> 6) then
    Exit;
{$EndRegion 'Validação inicial do dado preenchido no banco'}

  lNow := fNow;
  DecodeDateTime(lNow, lAno, lMes, lDia, lHora, lMin, lSeg, lMilSeg);

  lstrAux := Copy(lstrPeriodo, 1, 5);
  if TryStrToTime(lstrAux, ldtaAux) then
  begin
    DecodeTime(ldtaAux, lHora, lMin, lSeg, lMilSeg);
    lHrInicial := EncodeDateTime(lAno, lMes, lDia, lHora, lMin, 0, 0);
  end
  else
    Exit;

  lstrAux := Copy(lstrPeriodo, 7, 5);
  if TryStrToTime(lstrAux, ldtaAux) then
  begin
    DecodeTime(ldtaAux, lHora, lMin, lSeg, lMilSeg);
    lHrFinal := EncodeDateTime(lAno, lMes, lDia, lHora, lMin, 59, 0);
  end
  else
    Exit;

  if (lHrInicial <= lNow) And (lNow <= lHrFinal) then
    Result := True;

  if Result then
  begin
    lstrAux := 'Durante o horário das %0:shs às %1:shs não é permitida '+slineBreak+
               'a execução de rotinas de transferência de códigos. '+slineBreak+
               'Favor executá-las fora deste horário de expediente.';
    lstrAux := Format(lstrAux,
                      [FormatDateTime('hh:mm', lHrInicial), FormatDateTime('hh:mm', lHrFinal)]);
    fMensagem('ATENÇÃO', lstrAux, ['&Ok']);
  end;
end;
end.
