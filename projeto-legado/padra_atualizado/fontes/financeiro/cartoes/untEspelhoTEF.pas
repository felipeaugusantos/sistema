unit untEspelhoTEF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMemo, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, Uni, Data.DB, frxDMPExport, StrUtils;

type
  TfrmEspelhoTEF = class(TfrmPai)
    cxCupom: TcxMemo;
    btnImprimir: TBitBtnLocked;
    frxEspelhoJ: TfrxReport;
    frxEspelhoM: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxEspelhoJ_40P: TfrxReport;
    frxEspelhoM_40p: TfrxReport;
    procedure FormActivate(Sender: TObject);
    procedure cxCupomKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryCfgRel: TUniQuery;
    strNomImp,
    strTipImp: String;
    blnImprime: Boolean;
    FstrSeqCon: String ;
    FdtaDtaCad: TDateTime ;
    FstrNumNsu: String ;
    FstrTipCar: String ;
    function fEspelhoMovTef: Boolean ;
    function fEspelhoTefTra: Boolean ;
    function fUsaTefTra: Boolean ;
  public
    { Public declarations }
    strNumCar: String;
    strCodEmp: String;
    strCodCli: String;
    property SeqCon: String read FstrSeqCon write FstrSeqCon;
    property DtaCad: TDateTime read FdtaDtaCad write FdtaDtaCad;
    property NumNsu: String read FstrNumNsu write FstrNumNsu;
    property TipCar: String read FstrTipCar write FstrTipCar;
    function fEspelhoTEFCartao: Boolean;
  end;

var
  frmEspelhoTEF: TfrmEspelhoTEF;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgRel, untTypesSistema;

procedure TfrmEspelhoTEF.btnImprimirClick(Sender: TObject);
  Var
    frxRel: TfrxReport;
begin
  inherited;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');

  If blnImprime Then
  Begin

    If strTipImp = 'J' Then
    Begin
      If (fCfgSis('LAYTEF') = '40') Then
        frxRel := frxEspelhoJ_40p
      Else
        frxRel := frxEspelhoJ;
    End
    Else
    Begin
      If (fCfgSis('LAYTEF') = '40') Then
        frxRel := frxEspelhoM_40p
      Else
         frxRel := frxEspelhoM;

      frxRel.DotMatrixReport := True;
    End;

    frxRel.PrintOptions.Printer   := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
    frxRel.PreviewOptions.Buttons := [pbPrint,pbLoad,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

    frxRel.PrintOptions.ShowDialog := (strNomImp = '');

    frxRel.Script.Variables['IMPRES'] := cxCupom.Text;

    If frxRel.PrepareReport Then
      pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);

  End;

end;

procedure TfrmEspelhoTEF.cxCupomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    Close;
  End;
end;

procedure TfrmEspelhoTEF.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxCupom);
end;

procedure TfrmEspelhoTEF.FormCreate(Sender: TObject);
begin
  inherited;
  qryCfgRel := fCriaQuery(Self);
end;

function TfrmEspelhoTEF.fUsaTefTra: Boolean;
begin
  Result := MatchStr(fCfgSis('TEFCIT', varString), [OPCAO_CLISITEF, OPCAO_NCR]) ;
end;

function TfrmEspelhoTEF.fEspelhoMovTef: Boolean;
Var
  LqryDados: TUniQuery;
begin
  Result := False  ;

  LqryDados := fCriaQuery(Self);
  try
    LqryDados.SQL.Add('SELECT TEF_DESREG FROM MOVTEF WHERE ');
    LqryDados.SQL.Add('  TEF_DUPCAR = :DUPCAR AND ');
    LqryDados.SQL.Add('  TEF_EMPCAR = :EMPCAR AND ');
    LqryDados.SQL.Add('  TEF_CLICAR = :CLICAR ');
    LqryDados.SQL.Add('  AND TEF_CODREG LIKE "029%" ');

    LqryDados.ParamByName('DUPCAR').AsString := strNumCar;
    LqryDados.ParamByName('EMPCAR').AsString := strCodEmp;
    LqryDados.ParamByName('CLICAR').AsString := strCodCli;
    LqryDados.Open;

    cxCupom.Lines.Clear;
    If LqryDados.IsEmpty Then
    Begin
      pMensagemOk('Espelho do TEF não encontrado para este registro de cartão');
      blnFecharFormPai := True;
    End
    Else
    Begin
      Result := True;
      While (Not LqryDados.Eof) Do
      Begin
        cxCupom.Lines.Add(LqryDados.FieldByName('TEF_DESREG').AsString);
        LqryDados.Next;
      End;
    End;
  finally
    FreeAndNil(LqryDados);
  end ;

end;

function TfrmEspelhoTEF.fEspelhoTEFCartao: Boolean;
begin

  if fUsaTefTra then
    result := fEspelhoTefTra
  else
    Result := fEspelhoMovTef ;

end;

function TfrmEspelhoTEF.fEspelhoTefTra: Boolean;
Var
  LqryDados: TUniQuery;
  LlstComprovante: TStringList;
  LintCnt: Integer ;
begin
  Result := False  ;

  LqryDados := fCriaQuery(Self);
  LlstComprovante := TStringList.Create ;
  try
    LqryDados.SQL.Add(' SELECT TEFTRA.TFT_STATUS, TEFTRA.TFT_COMIMP FROM TEFTRA ');
    LqryDados.SQL.Add(' WHERE TFT_DTATRA = :DTATRA ');
    LqryDados.SQL.Add('       AND TFT_CODEMP = :CODEMP ');
    LqryDados.SQL.Add('       AND TFT_SEQCON = :SEQCON ');
    LqryDados.SQL.Add('       AND TFT_NUMNSU = :NUMNSU ');
    LqryDados.SQL.Add(' ORDER BY TFT_NUMDOC DESC ');
    LqryDados.SQL.Add(' LIMIT 1 ');

    LqryDados.ParamByName('NUMNSU').AsString := FstrNumNsu;
    LqryDados.ParamByName('DTATRA').AsDate := FdtaDtaCad ;
    LqryDados.ParamByName('CODEMP').AsString := strCodEmp;
    LqryDados.ParamByName('SEQCON').AsString := FstrSeqCon;
    LqryDados.Open;

    cxCupom.Lines.Clear;
    If LqryDados.IsEmpty Then
    Begin
      if FstrTipCar = 'TEF' then
        pMensagemOk('Espelho do TEF não encontrado para este registro de cartão')
      else
        pMensagemOk('Registro '+FstrTipCar+' não possui espelho do TEF!') ;
      blnFecharFormPai := True;
    End
    Else
    Begin
      if (fEmptyStr(LqryDados.FieldByName('TFT_COMIMP').AsString)) or
         (LqryDados.FieldByName('TFT_STATUS').AsString = 'PENDENTE') then
      begin

        if fMensagem('ATENÇÃO!', 'Espelho TEF não localizado!', ['&OK', '&Ajuda'], 1) = 2 then
          pMensagemOk('Possível Causa:'+ #13#10 +
                      '-Transação Pendente de confirmação, verificar no Relatório do TEF e no site da Operadora de Cartão.');


        Exit ;
      end ;

      LlstComprovante.Text := LqryDados.FieldByName('TFT_COMIMP').AsString ;

      Result := True;
      for LintCnt := 0 to LlstComprovante.Count-1 do
        cxCupom.Lines.Add(LlstComprovante.Strings[LintCnt]);

    End;
  finally
    FreeAndNil(LlstComprovante);
    FreeAndNil(LqryDados);
  end ;

end;

end.
