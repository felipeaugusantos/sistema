unit untCadAbfReformaTributaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Vcl.Mask, MaskEditFocus, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, uni, untZClient, dxmdaset, QColorLabel, System.Generics.Collections;

type
  TFotoAbf = TObjectDictionary<string, TStringList>;

  TLogRte = record
    Evento: string;
    AutRte: string;
    CodAbf: string;
    EntSai: string;
    CodCst: string;
    CodCla: string;
    NomCam: string;
    ValAnt: string;
    ValAtu: string;
  end;

  TCstCfop = record
    Cst: string;
    AutInc: string;
    Cfops: string; // Ex: '5102-5104-5103-6102'
    ClassTrib: string;
    procedure pLimpa;
  end;

  TEditHelper = class helper for TEdit
  public
    procedure SetValor(AValor: Double);
    function GetValor: Double;
  end;

  TCadOperacao = (tcoInclusao, tcoEdicao, tcoBrowser);

  TfrmCadAbfReformaTributaria = class(TfrmPai)
    btnPesquisa: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodApc: TEditFocus;
    edtDescri: TEditFocus;
    pnlProgresso: TPanel;
    lblInformacao: TLabel;
    pbProgresso: TcxProgressBar;
    pnlDados: TPanel;
    pnlSaida: TPanel;
    gpbSaida: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtCstSaida: TEditFocus;
    mskCfopSaida: TMaskEditFocus;
    btnConfirmaSaida: TBitBtnLocked;
    btnCancelaSaida: TBitBtnLocked;
    edtCodClaTribSai: TEditFocus;
    dbgSaida: TDBGridCitel;
    pnlEntrada: TPanel;
    gpbEntrada: TGroupBox;
    Label7: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    edtCstEntrada: TEditFocus;
    mskCfopEntrada: TMaskEditFocus;
    btnConfirmaEntrada: TBitBtnLocked;
    btnCancelaEntrada: TBitBtnLocked;
    edtCodClaTribEnt: TEditFocus;
    dtsSaida: TDataSource;
    dtsEntrada: TDataSource;
    dbgEntrada: TDBGridCitel;
    cdsSaida: TdxMemData;
    cdsSaidaCST: TStringField;
    cdsSaidaCLATRIB: TStringField;
    cdsSaidaCFOPS: TStringField;
    cdsSaidaAUTOINCREM: TStringField;
    cdsEntrada: TdxMemData;
    cdsEntradaCST: TStringField;
    cdsEntradaCLATRIB: TStringField;
    cdsEntradaCFOPS: TStringField;
    cdsEntradaAUTOINCREM: TStringField;
    cdsSaidaREMOVER: TStringField;
    cdsEntradaREMOVER: TStringField;
    btnAlterar: TBitBtnLocked;
    cdsSaidaCBSALQ: TFloatField;
    cdsSaidaCBSDIF: TFloatField;
    cdsSaidaCBSRED: TFloatField;
    cdsSaidaIBSUFA: TFloatField;
    cdsSaidaIBSUFD: TFloatField;
    cdsSaidaIBSUFR: TFloatField;
    cdsSaidaTRIREG: TStringField;
    cdsSaidaCREPRE: TStringField;
    edtDesClaTribSai: TEditFocus;
    Label26: TLabel;
    Label30: TLabel;
    edtDesClaTribEnt: TEditFocus;
    gpbAliquotasEntrada: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    edtCbsAlqEntrada: TEditFocus;
    edtCbsDifEntrada: TEditFocus;
    edtCbsRedEntrada: TEditFocus;
    edtIbsUfAEntrada: TEditFocus;
    edtIbsUfDEntrada: TEditFocus;
    edtIbsUfREntrada: TEditFocus;
    edtTriRegEntrada: TEditFocus;
    edtCrePreEntrada: TEditFocus;
    edtIbsTotEntrada: TEditFocus;
    gpbAliquotasSaida: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label27: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ColorLabel30: TColorLabel;
    Label15: TLabel;
    ColorLabel1: TColorLabel;
    Label16: TLabel;
    edtCbsAlqSaida: TEditFocus;
    edtCbsDifSaida: TEditFocus;
    edtCbsRedSaida: TEditFocus;
    edtIbsUfASaida: TEditFocus;
    edtIbsTotSaida: TEditFocus;
    edtIbsUfDSaida: TEditFocus;
    edtIbsUfRSaida: TEditFocus;
    edtTriRegSaida: TEditFocus;
    edtCrePreSaida: TEditFocus;
    cdsEntradaIBSTOT: TFloatField;
    cdsSaidaIBSTOT: TFloatField;
    Label17: TLabel;
    edtDesCstSaida: TEditFocus;
    edtDesCstEntrada: TEditFocus;
    Label18: TLabel;
    procedure edtCodClaTribEntKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClaTribSaiKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCstSaidaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCstEntradaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);

    procedure btnConfirmaSaidaClick(Sender: TObject);

    procedure btnConfirmaEntradaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaSaidaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgSaidaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgEntradaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaEntradaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mskCfopSaidaEnter(Sender: TObject);
    procedure edtCbsAlqSaidaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCbsAlqSaidaExit(Sender: TObject);
  private
    FCadOperacao: TCadOperacao;
    FQryConsulta: TUniQuery;
    FCstCfopEditaSaida: TCstCfop;
    FCstCfopEditaEntrada: TCstCfop;
    FListaExclusao: TStringList;
    procedure pGerenciaBotoes;
    procedure pGerenciaInputs;

    procedure pGerenciaInputsReadOnly;
    procedure pConfimaClick(AOperacaoaSaida: Boolean);
    function AgruparComHifen(ATexto: string): string;
    function ExisteConflito(const Lista: TArray<TCstCfop>; const Novo: TCstCfop): string;
    procedure pLimparConteudoDados;
    function fTemConflitoCFOP(ADataSet: TDataSet; ACstCfop: TCstCfop; var AConflito: string): Boolean;
    function fGravaAbreviacao: Boolean;
    procedure ApagaCSTs;
    procedure SetCadOperacao(const Value: TCadOperacao);
    procedure pLimpaEdits(AControl: TCustomControl);
    procedure pSetaValoresDefault;
    function fTrataStringCFOP(AValue: String): string;
    function fValidaCfopInformadaEntradaOuSaida(ACFOPs: string; AOperacaoSaida: Boolean): Boolean;
    function fCfopValidos(AListaGrupos: TStringList; AOperacaoSaida: Boolean): Boolean;
    procedure dbgKeyDown(Key: Word; AOperacaoSaida: Boolean);
    procedure CarregaAbf(ACodAbf: String);
    function fCamposValidos(arrCampos: TArray<TWinControl>): Boolean;
    function fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
    procedure pCalculaTotalIBS(ASaida: Boolean);
    function fFotoAbreviacao(const ACodAbf: string): TFotoAbf;
    procedure pGravaLogAbreviacao(const AAntes, ADepois: TFotoAbf; const AOrigem: Char);

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fVerificaCST_CLATRIB(ACst, ACodClaTrib: String; ASaida: Boolean = True): Boolean;
    function fAbreviacaoExiste: boolean;
    function fLocalizaCST(ACST: String; ASaida: Boolean = True): Boolean;
    procedure pLimpaCdsDados;

  public
    property CadOperacao: TCadOperacao read FCadOperacao write SetCadOperacao;
    { Public declarations }
  end;

var
  frmCadAbfReformaTributaria: TfrmCadAbfReformaTributaria;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples, untFuncoes;

{$R *.dfm}

procedure TfrmCadAbfReformaTributaria.pGerenciaBotoes;
begin
  btnIncluir.Enabled := (FCadOperacao = tcoBrowser);
  btnAlterar.Enabled := (FCadOperacao = tcoBrowser);
  btnGravar.Enabled :=  not (FCadOperacao = tcoBrowser);
  btnExcluir.Enabled := (FCadOperacao = tcoBrowser);
  btnCancela.Enabled := not (FCadOperacao = tcoBrowser);
  btnPesquisa.Enabled := (FCadOperacao = tcoBrowser);
  edtCodApc.Enabled := Not (FCadOperacao = tcoBrowser);
  edtDescri.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCstSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCodClaTribSai.Enabled := Not (FCadOperacao = tcoBrowser);
  mskCfopSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsAlqSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsDifSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsRedSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfASaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfDSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfRSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtTriRegSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCrePreSaida.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCstEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCodClaTribEnt.Enabled := Not (FCadOperacao = tcoBrowser);
  mskCfopEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsAlqEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsDifEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCbsRedEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfAEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfDEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtIbsUfREntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtTriRegEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
  edtCrePreEntrada.Enabled := Not (FCadOperacao = tcoBrowser);
end;

procedure TfrmCadAbfReformaTributaria.pLimpaCdsDados;
begin
  while not cdsSaida.IsEmpty do cdsSaida.delete;
  while not cdsEntrada.IsEmpty do cdsEntrada.delete;
end;

procedure TfrmCadAbfReformaTributaria.pLimpaEdits(AControl: TCustomControl);
var i: integer;
begin
  For i := 0 to AControl.ControlCount - 1 do
  begin
    If AControl.Controls[i] is TCustomEdit then
      TCustomEdit(AControl.Controls[i]).Clear;
  End;

  pSetaValoresDefault;
end;

procedure TfrmCadAbfReformaTributaria.pSetaValoresDefault;
begin
  edtCbsAlqSaida.SetValor(0);
  edtCbsDifSaida.SetValor(0);
  edtCbsRedSaida.SetValor(0);
  edtIbsUfASaida.SetValor(0);
  edtIbsUfDSaida.SetValor(0);
  edtIbsUfRSaida.SetValor(0);
  edtIbsTotSaida.SetValor(0);
  edtTriRegSaida.Text := 'N';
  edtCrePreSaida.Text := 'N';

  edtCbsAlqEntrada.SetValor(0);
  edtCbsDifEntrada.SetValor(0);
  edtCbsRedEntrada.SetValor(0);
  edtIbsUfAEntrada.SetValor(0);
  edtIbsUfDEntrada.SetValor(0);
  edtIbsUfREntrada.SetValor(0);
  edtIbsTotEntrada.SetValor(0);
  edtTriRegEntrada.Text := 'N';
  edtCrePreEntrada.Text := 'N';
end;

procedure TfrmCadAbfReformaTributaria.pLimparConteudoDados;
begin
  edtCstSaida.Clear;
  edtCodClaTribSai.Clear;
  mskCfopSaida.Clear;
  edtCstEntrada.Clear;
  edtCodClaTribEnt.Clear;
  mskCfopEntrada.Clear;
  edtCodApc.Clear;
  edtDescri.Clear;
End;

procedure TfrmCadAbfReformaTributaria.pGerenciaInputs;
begin
  case FCadOperacao of
    tcoInclusao: begin
                   pnlGeral.Enabled := True;
                   edtCodApc.Enabled := True;
                   edtDescri.Enabled := True;
                   pSetFocus(edtCodApc);
                   pLimparConteudoDados;
                   pLimpaCdsDados;
                 End;
      tcoEdicao: begin
                   pnlGeral.Enabled := True;
                   edtCodApc.Enabled := False;
                   edtDescri.Enabled := True;
                   pSetFocus(edtCstSaida);
                   FListaExclusao.Clear;
                 End;
     tcoBrowser: begin
                   pnlGeral.Enabled := False;
                 End;
  end;
  pGerenciaInputsReadOnly;
end;

procedure TfrmCadAbfReformaTributaria.pGerenciaInputsReadOnly;
var i: integer;
begin
  For i := 0 To gpbSaida.ControlCount -1 do
  begin
    If gpbSaida.Controls[i] is TCustomEdit then
      TCustomEdit(gpbSaida.Controls[i]).ReadOnly := (FCadOperacao = tcoBrowser);
  end;
  For i := 0 To gpbEntrada.ControlCount -1 do
  begin
    If gpbEntrada.Controls[i] is TCustomEdit then
      TCustomEdit(gpbEntrada.Controls[i]).ReadOnly := (FCadOperacao = tcoBrowser);
  end;
  dbgSaida.readonly := (FCadOperacao = tcoBrowser);
  dbgEntrada.readonly := (FCadOperacao = tcoBrowser);
end;

procedure TfrmCadAbfReformaTributaria.SetCadOperacao(const Value: TCadOperacao);
begin
  FCadOperacao := Value;
  pGerenciaBotoes;
  pGerenciaInputs;
end;

procedure TfrmCadAbfReformaTributaria.ApagaCSTs;
begin
  If FListaExclusao.Count > 0 Then
  begin
    FQryConsulta.SQL.Clear;
    FQryConsulta.SQL.Add('DELETE FROM ABFRTE WHERE AUTOINCREM IN ('+FListaExclusao.CommaText+')');
    FQryConsulta.ExecSQL;
    FQryConsulta.SQL.Clear;
  End;
end;

procedure TfrmCadAbfReformaTributaria.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If not fEmptyStr(edtCodApc.Text) then
    CadOperacao := tcoEdicao;

  FCstCfopEditaSaida.pLimpa;
  FCstCfopEditaEntrada.pLimpa;
end;

procedure TfrmCadAbfReformaTributaria.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodApc.Text)) and (not edtCodApc.Enabled) Then
    CarregaAbf(edtCodApc.Text)
  Else
  Begin
    pLimparConteudoDados;
    pLimpaCdsDados;
  End;
  FListaExclusao.Clear;
  CadOperacao := tcoBrowser;

  FCstCfopEditaSaida.pLimpa;
  FCstCfopEditaEntrada.pLimpa;

  btnCancelaSaida.Click;
  btnCancelaEntrada.Click;
end;

procedure TfrmCadAbfReformaTributaria.btnCancelaEntradaClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits(gpbEntrada);
  FCstCfopEditaEntrada.pLimpa;
  pSetFocus(edtCstEntrada);
end;

procedure TfrmCadAbfReformaTributaria.btnCancelaSaidaClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits(gpbSaida);
  FCstCfopEditaSaida.pLimpa;
  pSetFocus(edtCstSaida);
end;

procedure TfrmCadAbfReformaTributaria.btnConfirmaEntradaClick(Sender: TObject);
begin
  pConfimaClick(False);
end;

function fTemCfopComMenosDe4Digitos(ACfop: String): Boolean;
var
  intCount : Integer;
begin
  Result := False;

  ACfop := fRemoveCaracteres(ACfop, ' -');

  if fEmptyStr(ACfop) then
    Exit;

  intCount := 1;
  while intCount <= Length(ACfop) do
  begin
    Result := (Length(Copy(ACfop, intCount, 4)) < 4);

    if Result then
      Break;

    Inc(intCount, 4);
  end;
end;

function TfrmCadAbfReformaTributaria.fValidaCfopInformadaEntradaOuSaida(ACFOPs: string; AOperacaoSaida: Boolean): Boolean;
var
  i: Integer;
  StrSemFormatacao, Grupo: string;
  ListaGrupos: TStringList;
  Erros: TStringList;
  PrimeiroChar: Char;
  OperacaoValida: Boolean;
begin
  Result := True;

  // Remove todos os espaços e hífens
  StrSemFormatacao := StringReplace(ACFOPs, ' ', '', [rfReplaceAll]);
  StrSemFormatacao := StringReplace(StrSemFormatacao, '-', '', [rfReplaceAll]);

  // Cria listas para armazenar os grupos e erros
  ListaGrupos := TStringList.Create;
  Erros := TStringList.Create;
  try
    ListaGrupos.Sorted := True;
    ListaGrupos.Duplicates := dupIgnore;

    // Quebra a string em grupos de 4 caracteres
    i := 1;
    while i <= Length(StrSemFormatacao) do
    begin
      Grupo := Copy(StrSemFormatacao, i, 4);

      // Verifica se o grupo tem exatamente 4 caracteres
      if Length(Grupo) = 4 then
        ListaGrupos.Add(Grupo);
      Inc(i, 4);
    end;

    // Valida o primeiro caractere de cada grupo único
    for i := 0 to ListaGrupos.Count - 1 do
    begin
      Grupo := ListaGrupos[i];
      PrimeiroChar := Grupo[1];

      if AOperacaoSaida then
        OperacaoValida := (PrimeiroChar = '5') or (PrimeiroChar = '6') or (PrimeiroChar = '7')
      else
        OperacaoValida := (PrimeiroChar = '1') or (PrimeiroChar = '2') or (PrimeiroChar = '3');
      if not OperacaoValida then
      begin
        Result := False;
        if AOperacaoSaida then
          Erros.Add(Format('CFOP %s: Primeiro dígito deve ser 5, 6 ou 7 para operação de Saída', [Grupo]))
        else
          Erros.Add(Format('CFOP %s: Primeiro dígito deve ser 1, 2 ou 3 para operação de Entrada', [Grupo]))
      end;
    end;

    if fEmptyStr(StrSemFormatacao) then
      Erros.Add('O preenchimento do campo CFOP é obrigatório!');

    // Exibe mensagens de erro se houver falhas
    if Erros.Count > 0 then
    begin
      pMensagemOk('Erros encontrados na validação de CFOP:' + sLineBreak + sLineBreak +
                 Erros.Text);

      if AOperacaoSaida then
        pSetFocus(mskCfopSaida)
      else
        pSetFocus(mskCfopEntrada);
    end;

    // Resultado final considera se houve erros de validação
    Result := Result and (Erros.Count = 0);
    If Result then
      Result := fCfopValidos(ListaGrupos, AOperacaoSaida);

  finally
    ListaGrupos.Free;
    Erros.Free;
  end;
end;

function TfrmCadAbfReformaTributaria.fVerificaCST_CLATRIB(ACst, ACodClaTrib: String; ASaida: Boolean = True): Boolean;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT NOME_CCLASSTRIB FROM CLASSTRIBPUBLICACAO');
  FQryConsulta.SQL.Add('WHERE CCLASSTRIB = "' + ACodClaTrib + '"');
  If not fEmptyStr(ACst) then
    FQryConsulta.SQL.Add('  AND CST_IBS_CBS = "' + ACst + '"');
  FQryConsulta.Open;
  Result := (Not FQryConsulta.IsEmpty);

  If (Result) Then
    If (ASaida) Then
      edtDesClaTribSai.Text := FQryConsulta.FieldByName('NOME_CCLASSTRIB').AsString
    Else
      edtDesClaTribEnt.Text := FQryConsulta.FieldByName('NOME_CCLASSTRIB').AsString;
end;

procedure TfrmCadAbfReformaTributaria.mskCfopSaidaEnter(Sender: TObject);
begin
  inherited;
   TMaskEditFocus(Sender).SelStart := 0;
   TMaskEditFocus(Sender).SelLength := 0;
end;

procedure TfrmCadAbfReformaTributaria.btnConfirmaSaidaClick(Sender: TObject);
begin
  inherited;

  pConfimaClick(True);
end;

procedure TfrmCadAbfReformaTributaria.pCalculaTotalIBS(ASaida: Boolean);
Var
    LIBSUfA,
    LIBSUfD,
    LIBSUfR: Double;
    LedtIBSTot: TEditFocus;
begin

  If ASaida then
  begin
    LIBSUfA := fStrToFloat(Trim(StringReplace(edtIbsUfASaida.Text, '%', '', [rfReplaceAll])));
    LIBSUfD := fStrToFloat(Trim(StringReplace(edtIbsUfDSaida.Text, '%', '', [rfReplaceAll])));
    LIBSUfR := fStrToFloat(Trim(StringReplace(edtIbsUfRSaida.Text, '%', '', [rfReplaceAll])));
    LedtIbsTot := edtIbsTotSaida;
  end
  Else
  Begin
    LIBSUfA := fStrToFloat(Trim(StringReplace(edtIbsUfAEntrada.Text, '%', '', [rfReplaceAll])));
    LIBSUfD := fStrToFloat(Trim(StringReplace(edtIbsUfDEntrada.Text, '%', '', [rfReplaceAll])));
    LIBSUfR := fStrToFloat(Trim(StringReplace(edtIbsUfREntrada.Text, '%', '', [rfReplaceAll])));
    LedtIbsTot := edtIbsTotEntrada;
  End;

  LedtIbsTot.Text := fFloatToStrVirgula(LIBSUfA + LIBSUfD + LIBSUfR, 3, 2) + ' %';
end;

function TfrmCadAbfReformaTributaria.fCamposValidos(arrCampos: TArray<TWinControl>): Boolean;
var
  winControl: TWinControl;
begin
  Result := True;

  for winControl in arrCampos do
    If not fValidaCampos(winControl) then
      Exit(False)
end;

procedure TfrmCadAbfReformaTributaria.pConfimaClick(AOperacaoaSaida: Boolean);
var lConflitos: string;
    CstCfop: TCstCfop;
    lmskCfop: TMaskEditFocus;
    ledtCst: TEditFocus;
    lCstCfopEdita: TCstCfop;
    lcds: TdxMemData;
    ledtCodClaTrib,
    ledtCbsAlq,
    ledtCbsDif,
    ledtCbsRed,
    ledtIbsUfA,
    ledtIbsUfD,
    ledtIbsUfR,
    ledtTriReg,
    ledtCrePre: TEditFocus;
    lgpb: TGroupBox;
begin
  inherited;
  try
    If AOperacaoaSaida then
    begin
      lmskCfop := mskCfopSaida;
      ledtCst := edtCstSaida;
      lCstCfopEdita := FCstCfopEditaSaida;
      lcds := cdsSaida;
      ledtCodClaTrib := edtCodClaTribSai;
      ledtCbsAlq := edtCbsAlqSaida;
      ledtCbsDif := edtCbsDifSaida;
      ledtCbsRed := edtCbsRedSaida;
      ledtIbsUfA := edtIbsUfASaida;
      ledtIbsUfD := edtIbsUfDSaida;
      ledtIbsUfR := edtIbsUfRSaida;
      ledtTriReg := edtTriRegSaida;
      ledtCrePre := edtCrePreSaida;
      lgpb := gpbSaida;
    end
    Else
    Begin
      lmskCfop := mskCfopEntrada;
      ledtCst := edtCstEntrada;
      lCstCfopEdita := FCstCfopEditaEntrada;
      lcds := cdsEntrada;
      ledtCodClaTrib := edtCodClaTribEnt;
      ledtCbsAlq := edtCbsAlqEntrada;
      ledtCbsDif := edtCbsDifEntrada;
      ledtCbsRed := edtCbsRedEntrada;
      ledtIbsUfA := edtIbsUfAEntrada;
      ledtIbsUfD := edtIbsUfDEntrada;
      ledtIbsUfR := edtIbsUfREntrada;
      ledtTriReg := edtTriRegEntrada;
      ledtCrePre := edtCrePreEntrada;
      lgpb := gpbEntrada;
    End;

    If ledtcst.ReadOnly then
    begin
      pMensagemOk('O processo não esta em edição!');
      Exit;
    End;

    If fEmptyStr(ledtCst.Text) then
    begin
      pMensagemOk('CST não foi informada!');
      Exit;
    End;

    if not fCamposValidos([ledtCst, ledtCodClaTrib, lmskCfop, ledtCbsAlq, ledtCbsDif, ledtCbsRed, ledtIbsUfA, ledtIbsUfD, ledtIbsUfR, ledtTriReg, ledtCrePre]) then
      Exit;

    CstCfop.Cst := ledtCst.Text;
    If not fValidaCfopInformadaEntradaOuSaida(lmskCfop.Text, AOperacaoaSaida) then
      Exit;

    CstCfop.Cfops := fTrataStringCFOP(lmskCfop.Text);

    CstCfop.AutInc := lCstCfopEdita.AutInc;
    CstCfop.ClassTrib := ledtCodClaTrib.Text;

    If fTemConflitoCFOP(lcds, CstCfop, lConflitos) then
    begin
      pMensagemOk(lConflitos);
      Exit;
    End;

    If lcds.Locate('CST;CLATRIB', VarArrayOf([ledtCst.Text, ledtCodClaTrib.Text]), []) then
    begin
      If lcds.FieldByName('AUTOINCREM').AsString <> lCstCfopEdita.AutInc then
      Begin
        pMensagemOk('CST e Classificação Tributária já cadastrada!');
        Exit;
      End;
      lcds.Edit;
    End
    Else  If (not fEmptyStr(CstCfop.AutInc)) and  lcds.Locate('AUTOINCREM', CstCfop.AutInc, []) then
      lcds.Edit
    Else
    begin
      lcds.Insert;
      lcds.FieldByName('AUTOINCREM').AsString := FormatDateTime('hhnnsszzzz', fnow);
      lcds.FieldByName('REMOVER').AsString := 'N';
    End;

    lcds.FieldByName('CST').AsString := ledtCst.Text;
    lcds.FieldByName('CLATRIB').AsString := ledtCodClaTrib.Text;
    lcds.FieldByName('CFOPS').AsString := CstCfop.Cfops;
    lcds.FieldByName('CBSALQ').AsFloat := ledtCbsAlq.GetValor;
    lcds.FieldByName('CBSDIF').AsFloat := ledtCbsDif.GetValor;
    lcds.FieldByName('CBSRED').AsFloat := ledtCbsRed.GetValor;
    lcds.FieldByName('IBSUFA').AsFloat := ledtIbsUfA.GetValor;
    lcds.FieldByName('IBSUFD').AsFloat := ledtIbsUfD.GetValor;
    lcds.FieldByName('IBSUFR').AsFloat := ledtIbsUfR.GetValor;
    lcds.FieldByName('TRIREG').AsString := IIF(ledtTriReg.Text = 'S', 'SIM', 'NÃO');
    lcds.FieldByName('CREPRE').AsString := IIF(ledtCrePre.Text = 'S', 'SIM', 'NÃO');
    lcds.Post;

    pLimpaEdits(lgpb);
    lCstCfopEdita.pLimpa;
    if AOperacaoaSaida then
      pSetFocus(edtCstSaida)
    else
      pSetFocus(edtCstEntrada);
  finally
  End;
End;

procedure TfrmCadAbfReformaTributaria.btnExcluirClick(Sender: TObject);
  Var
    objFotAntes: TFotoAbf;
    objFotDepois: TFotoAbf;
begin
  inherited;
  If fEmptyStr(edtCodApc.Text) then
  begin
    pMensagemOk('Nenhuma abreviação selecionada!');
    Exit;
  end;
  If Not fPergunta('Excluir a Abreviação ' + edtCodApc.text + ' ' + edtDescri.Text + '?') Then
    Exit;
  objFotDepois := nil;
  Try
    fStartTransaction;
    objFotAntes := fFotoAbreviacao(edtCodApc.Text);
    Try
      FQryConsulta.SQL.Text := 'DELETE FROM ABFRTE WHERE RTE_CODABF = "'+edtCodApc.Text+'"';
      FQryConsulta.ExecSQL;
      FQryConsulta.SQL.Clear;
      objFotDepois := fFotoAbreviacao(edtCodApc.Text);
      Try
        pGravaLogAbreviacao(objFotAntes, objFotDepois, 'E');
        fCommit;

        pLimparConteudoDados;
        pLimpaCdsDados;
        CadOperacao := tcoBrowser;
        FListaExclusao.Clear;

        FCstCfopEditaSaida.pLimpa;
        FCstCfopEditaEntrada.pLimpa;
      Finally
        FreeAndNil(objFotDepois);
      End;
    Finally
      FreeAndNil(objFotAntes);
    End;
  Except
    On E: Exception do
    begin
      If fInTransaction Then
        fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAbfReformaTributaria.btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadAbfReformaTributaria.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fGravaAbreviacao then
    CadOperacao := tcoBrowser;
end;

procedure TfrmCadAbfReformaTributaria.btnIncluirClick(Sender: TObject);
begin
  inherited;
  CadOperacao := tcoInclusao;

  FCstCfopEditaSaida.pLimpa;
  FCstCfopEditaEntrada.pLimpa;
end;

procedure TfrmCadAbfReformaTributaria.CarregaAbf(ACodAbf: String);
var cds: TdxMemData;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT * FROM ABFRTE WHERE RTE_CODABF = "'+ACodAbf+'"');
  FQryConsulta.Open;
  edtCodApc.Text := FQryConsulta.FieldByName('RTE_CODABF').AsString;
  edtDescri.Text := FQryConsulta.FieldByName('RTE_DESABF').AsString;
  pLimpaCdsDados;
  while not  FQryConsulta.Eof do
  begin
    If FQryConsulta.FieldByName('RTE_ENTSAI').AsString = 'E' then
      cds := cdsEntrada
    Else
      cds := cdsSaida;

    cds.Insert;
    cds.FieldByName('CST').AsString := FQryConsulta.FieldByName('RTE_CODCST').AsString;
    cds.FieldByName('CLATRIB').AsString := FQryConsulta.FieldByName('RTE_CODCLA').AsString;
    cds.FieldByName('CFOPS').AsString := AgruparComHifen(FQryConsulta.FieldByName('RTE_CLAFIS').AsString);
    cds.FieldByName('CBSALQ').AsFloat := FQryConsulta.FieldByName('RTE_CBSALQ').AsFloat;
    cds.FieldByName('CBSDIF').AsFloat := FQryConsulta.FieldByName('RTE_CBSDIF').AsFloat;
    cds.FieldByName('CBSRED').AsFloat := FQryConsulta.FieldByName('RTE_CBSRED').AsFloat;
    cds.FieldByName('IBSUFA').AsFloat := FQryConsulta.FieldByName('RTE_IBSUFA').AsFloat;
    cds.FieldByName('IBSUFD').AsFloat := FQryConsulta.FieldByName('RTE_IBSUFD').AsFloat;
    cds.FieldByName('IBSUFR').AsFloat := FQryConsulta.FieldByName('RTE_IBSUFR').AsFloat;
    cds.FieldByName('TRIREG').AsString := IIF(FQryConsulta.FieldByName('RTE_TRIREG').AsString = 'S', 'SIM', 'NÃO');
    cds.FieldByName('CREPRE').AsString := IIF(FQryConsulta.FieldByName('RTE_CREPRE').AsString = 'S', 'SIM', 'NÃO');
    cds.FieldByName('AUTOINCREM').AsString := FQryConsulta.FieldByName('AUTOINCREM').AsString;
    cds.FieldByName('REMOVER').AsString := 'N';

    cds.Post;
    FQryConsulta.Next;
  end;
end;

procedure TfrmCadAbfReformaTributaria.btnPesquisaClick(Sender: TObject);
var lQry: TUniQuery;
    Key: Char;
    arrSel : TConsultasArray;
begin
  inherited;
  FCstCfopEditaSaida.pLimpa;
  FCstCfopEditaEntrada.pLimpa;

  lQry := fCriaQuery;
  Try
    Key := '/';
    If fPesqAbreviacaoReformaTributaria(Self, nil, nil, lQry, Key, arrSel) then
      CarregaAbf(lQry.FieldByName('RTE_CODABF').AsString);
  Finally
    FreeAndNil(lQry);
  End;
end;

procedure TfrmCadAbfReformaTributaria.dbgSaidaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dbgKeyDown(Key, True);
end;

procedure TfrmCadAbfReformaTributaria.dbgEntradaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dbgKeyDown(Key, False);

end;

procedure TfrmCadAbfReformaTributaria.dbgKeyDown(Key: Word; AOperacaoSaida: Boolean);
var lmskCfop: TMaskEditFocus;
    ledtCst: TEditFocus;
    lcds: TdxMemData;
    ledtCodClaTrib,
    ledtCbsAlq,
    ledtCbsDif,
    ledtCbsRed,
    ledtIbsUfA,
    ledtIbsUfD,
    ledtIbsUfR,
    ledtTriReg,
    ledtCrePre: TEditFocus;

    procedure pSetaCstCfopEdita(var ACstCfop: TCstCfop; Acst, ACfopes, AAutinc, AClassTrib: string);
    begin
      ACstCfop.Cst := Acst;
      ACstCfop.AutInc := AAutinc;
      ACstCfop.Cfops := ACfopes;
      ACstCfop.ClassTrib := AClassTrib;
    End;

begin
  inherited;
  If AOperacaoSaida then
  begin
    lmskCfop := mskCfopSaida;
    ledtCst := edtCstSaida;
    lcds := cdsSaida;
    ledtCodClaTrib := edtCodClaTribSai;
    ledtCbsAlq := edtCbsAlqSaida;
    ledtCbsDif := edtCbsDifSaida;
    ledtCbsRed := edtCbsRedSaida;
    ledtIbsUfA := edtIbsUfASaida;
    ledtIbsUfD := edtIbsUfDSaida;
    ledtIbsUfR := edtIbsUfRSaida;
    ledtTriReg := edtTriRegSaida;
    ledtCrePre := edtCrePreSaida;
  end
  Else
  Begin
    lmskCfop := mskCfopEntrada;
    ledtCst := edtCstEntrada;
    lcds := cdsEntrada;
    ledtCodClaTrib := edtCodClaTribEnt;
    ledtCbsAlq := edtCbsAlqEntrada;
    ledtCbsDif := edtCbsDifEntrada;
    ledtCbsRed := edtCbsRedEntrada;
    ledtIbsUfA := edtIbsUfAEntrada;
    ledtIbsUfD := edtIbsUfDEntrada;
    ledtIbsUfR := edtIbsUfREntrada;
    ledtTriReg := edtTriRegEntrada;
    ledtCrePre := edtCrePreEntrada;
  End;

  case  Key  of
    VK_RETURN: Begin
                 ledtCst.Text := lcds.FieldByName('CST').AsString;
                 ledtCodClaTrib.Text := lcds.FieldByName('CLATRIB').AsString;
                 lmskCfop.Text := lcds.FieldByName('CFOPS').AsString;
                 ledtCbsAlq.SetValor(lcds.FieldByName('CBSALQ').AsFloat);
                 ledtCbsDif.SetValor(lcds.FieldByName('CBSDIF').AsFloat);
                 ledtCbsRed.SetValor(lcds.FieldByName('CBSRED').AsFloat);
                 ledtIbsUfA.SetValor(lcds.FieldByName('IBSUFA').AsFloat);
                 ledtIbsUfD.SetValor(lcds.FieldByName('IBSUFD').AsFloat);
                 ledtIbsUfR.SetValor(lcds.FieldByName('IBSUFR').AsFloat);
                 ledtTriReg.Text := IIF(lcds.FieldByName('TRIREG').AsString = 'SIM', 'S', 'N');
                 ledtCrePre.Text := IIF(lcds.FieldByName('CREPRE').AsString = 'SIM', 'S', 'N');

                 CadOperacao := tcoEdicao;
                 If AOperacaoSaida then
                   pSetaCstCfopEdita(FCstCfopEditaSaida, ledtCst.Text, lmskCfop.Text, lcds.FieldByName('AUTOINCREM').AsString, ledtCodClaTrib.Text)
                 else
                   pSetaCstCfopEdita(FCstCfopEditaEntrada, ledtCst.Text, lmskCfop.Text, lcds.FieldByName('AUTOINCREM').AsString, ledtCodClaTrib.Text);

                 pCalculaTotalIBS(AOperacaoSaida);
                 pSetFocus(ledtCst);
               End;
    VK_DELETE: Begin
                 If FCadOperacao = tcoBrowser then
                   Exit;
                 if fPergunta('Deseja excluir esta linha?') then
                 Begin
                   If (Length(lcds.FieldByName('AUTOINCREM').AsString) = 20) then
                     FListaExclusao.Add(QuotedStr(lcds.FieldByName('AUTOINCREM').AsString));
                   lcds.delete;
                 End;
               End;
  end;
End;

function TfrmCadAbfReformaTributaria.AgruparComHifen(ATexto: string): string;
var
  i: Integer;
begin
  Result := '';
  ATexto := StringReplace(ATexto, ' ', '', [rfReplaceAll]);
  for i := 1 to Length(ATexto) do
  begin
    Result := Result + ATexto[i];
    if (i mod 4 = 0) and (i < Length(ATexto)) then
      Result := Result + '-';
  end;
end;


procedure TfrmCadAbfReformaTributaria.edtCbsAlqSaidaExit(Sender: TObject);
var
  Valor: Double;
  Texto: string;
begin
  inherited;

  Texto := StringReplace(TEditFocus(Sender).Text, '%', '', [rfReplaceAll]);
  Texto := Trim(Texto);

  Texto := StringReplace(Texto, '.', ',', [rfReplaceAll]);

  if TryStrToFloat(Texto, Valor) then
    TEditFocus(Sender).Text := FormatFloat('0.00', Valor) + ' %'
  else
    TEditFocus(Sender).Text := '';

  If (Sender = edtIbsUfASaida) Or
     (Sender = edtIbsUfDSaida) Or
     (Sender = edtIbsUfRSaida) Then
    pCalculaTotalIBS(True)
  Else If (Sender = edtIbsUfAEntrada) Or
          (Sender = edtIbsUfDEntrada) Or
          (Sender = edtIbsUfREntrada) Then
    pCalculaTotalIBS(False);

end;

procedure TfrmCadAbfReformaTributaria.edtCbsAlqSaidaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not CharInSet(Key, ['0'..'9', ',', '.', '%', #8]) then
    Key := #0;

  if CharInSet(Key, [',','.']) and (Pos(',', TEdit(Sender).Text) > 0) then
    Key := #0;

  if (Key = '%') and (Pos('%', TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TfrmCadAbfReformaTributaria.edtCodClaTribEntKeyPress(Sender: TObject; var Key: Char);
var arrSel : TConsultasArray;
    strCst: string;
begin
  inherited;
  If edtCstEntrada.ReadOnly then
    Exit;
  strCst := edtCstEntrada.Text;
  If fPesqReformaTributaria(Self, edtCodClaTribEnt, nil, nil, Key, arrSel, strCst) Then
  Begin
    edtCstEntrada.Text := strCst;
    pSetFocus(mskCfopEntrada);
  End;
end;

procedure TfrmCadAbfReformaTributaria.edtCodClaTribSaiKeyPress(Sender: TObject; var Key: Char);
var arrSel : TConsultasArray;
    strCst: string;
begin
  inherited;
  If edtCstEntrada.ReadOnly then
    Exit;

  strCst := edtCstSaida.Text;
  If fPesqReformaTributaria(Self, edtCodClaTribSai, edtDesClaTribSai, nil , Key, arrSel, strCst) Then
  Begin
    edtCstSaida.Text := strCst;
    pSetFocus(mskCfopSaida);
  End;
end;

procedure TfrmCadAbfReformaTributaria.edtCstEntradaKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If edtCstEntrada.ReadOnly then
    Exit;

  if fPesqCSTReformaTributaria(Self, edtCstEntrada, edtDesCstEntrada, Nil, Key, arrSel) then
    pSetFocus(edtCodClaTribEnt);
end;

procedure TfrmCadAbfReformaTributaria.edtCstSaidaKeyPress(Sender: TObject; var Key: Char);
Var arrSel: TConsultasArray;
begin
  inherited;
  If edtCstEntrada.ReadOnly then
    Exit;

  if fPesqCSTReformaTributaria(Self, edtCstSaida, edtDesCstSaida, Nil, Key, arrSel) then
    pSetFocus(edtCodClaTribSai);
end;

procedure TfrmCadAbfReformaTributaria.FormCreate(Sender: TObject);
begin
  inherited;
  FCadOperacao := tcoBrowser;
  FQryConsulta := fCriaQuery;
  FCstCfopEditaSaida.pLimpa;
  FCstCfopEditaEntrada.pLimpa;
  FListaExclusao := TStringList.Create;

  pGerenciaBotoes;
end;

procedure TfrmCadAbfReformaTributaria.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FQryConsulta);
  FreeAndNil(FListaExclusao);
  inherited;
end;

procedure TfrmCadAbfReformaTributaria.FormResize(Sender: TObject);
var
  intHeightGrid: Integer;
begin
  inherited;

  intHeightGrid := dbgSaida.Height + dbgEntrada.Height;
  dbgSaida.Height := intHeightGrid div 2;
  dbgEntrada.Height := intHeightGrid div 2;
end;

function TfrmCadAbfReformaTributaria.fTemConflitoCFOP(ADataSet: TDataSet; ACstCfop: TCstCfop; var AConflito: string): Boolean;
var Lista: TArray<TCstCfop>;
begin
  ADataSet.First;
  while not ADataSet.Eof do
  begin
    Try
      If ACstCfop.AutInc = ADataSet.FieldByName('AUTOINCREM').AsString then
        Continue;
      SetLength(Lista, ADataSet.RecNo);
      Lista[ADataSet.RecNo -1].Cst := ADataSet.FieldByName('CST').AsString;
      Lista[ADataSet.RecNo -1].Cfops := ADataSet.FieldByName('CFOPS').AsString;
      Lista[ADataSet.RecNo -1].AutInc := ADataSet.FieldByName('AUTOINCREM').AsString;
      Lista[ADataSet.RecNo -1].ClassTrib := ADataSet.FieldByName('CLATRIB').AsString;
    Finally
      ADataSet.Next;
    End;
  End;
  AConflito := ExisteConflito(Lista, ACstCfop);
  Result := Not fEmptyStr(AConflito);
end;

function TfrmCadAbfReformaTributaria.fTrataStringCFOP(AValue: String): string;
var
  i: Integer;
  StrSemFormatacao, Grupo: string;
  ListaGrupos: TStringList;
begin
  Result := '';

  // Remove todos os espaços e hífens
  StrSemFormatacao := StringReplace(AValue, ' ', '', [rfReplaceAll]);
  StrSemFormatacao := StringReplace(StrSemFormatacao, '-', '', [rfReplaceAll]);

  // Cria uma lista para armazenar os grupos únicos
  ListaGrupos := TStringList.Create;
  try
    ListaGrupos.Sorted := True;
    ListaGrupos.Duplicates := dupIgnore;

    // Quebra a string em grupos de 4 caracteres
    i := 1;
    while i <= Length(StrSemFormatacao) do
    begin
      Grupo := Copy(StrSemFormatacao, i, 4);
      if Length(Grupo) = 4 then
      begin
        // Adiciona o grupo à lista (automaticamente remove duplicatas)
        ListaGrupos.Add(Grupo);
      end;
      Inc(i, 4);
    end;

    // Reconstrói a string com os grupos únicos separados por hífen
    for i := 0 to ListaGrupos.Count - 1 do
    begin
      if Result <> '' then
        Result := Result + '-';
      Result := Result + ListaGrupos[i];
    end;

  finally
    ListaGrupos.Free;
  end;
end;

function TfrmCadAbfReformaTributaria.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodApc) Then
  Begin
    If fEmptyStr(edtCodApc.Text) Then
    Begin
      fMensagem('', 'O código da abreviação deve ser preenchido.', ['&Ok']);
      Result := False;
    End
    Else If (fAbreviacaoExiste) And (CadOperacao = tcoInclusao) Then
    Begin
      fMensagem('', 'Já existe uma abreviação com esse código.', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCstSaida)  then
  Begin
    If fEmptyStr(edtCstSaida.Text) Then
    Begin
      edtDesCstSaida.Clear;
      fMensagem('', 'O CST deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If Not fLocalizaCST(edtCstSaida.Text, True) then
    begin
      edtDesCstSaida.Clear;
      fMensagem('', 'O CST informado não é válido, verifique a tabela de CST.', ['&Ok']);
      Result := False;
    end;
  End
  Else if Sender = edtCodClaTribSai then
  Begin
    If fEmptyStr(edtCodClaTribSai.Text) then
    begin
      fMensagem('', 'A Classificação Tributária deve ser Informada!', ['&Ok']);
      Result := False;
    End
    Else If not fVerificaCST_CLATRIB(edtCstSaida.Text,edtCodClaTribSai.Text, True) Then
    begin
      edtDesClaTribSai.Clear;
      If fEmptyStr(edtCstSaida.Text) Then
        fMensagem('', 'Classificação Tributária não encontrada.', ['&Ok'])
      Else
        fMensagem('', 'A Classificação Tributária não é compatível com a CST.', ['&Ok']);
      edtCodClaTribSai.Text := '';
      Result := False;
    End;
  End

  Else If (Sender = edtCstEntrada) then
  Begin
    If fEmptyStr(edtCstEntrada.Text) Then
    Begin
      edtDesCstEntrada.Clear;
      fMensagem('', 'O CST deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If Not fLocalizaCST(edtCstEntrada.Text, False) then
    begin
      edtDesCstEntrada.Clear;
      fMensagem('', 'O CST informado não é válido, verifique a tabela de CST.', ['&Ok']);
      Result := False;
    end;
  End
  Else if Sender = edtCodClaTribEnt then
  Begin
    If fEmptyStr(edtCodClaTribEnt.Text) then
    begin
      fMensagem('', 'A Classificação Tributária deve ser Informada!', ['&Ok']);
      Result := False;
    End
    Else If not fVerificaCST_CLATRIB(edtCstEntrada.Text,edtCodClaTribEnt.Text, False) Then
    begin
      edtDesClaTribEnt.Clear;
      If fEmptyStr(edtCstEntrada.Text) Then
        fMensagem('', 'Classificação Tributária não encontrada.', ['&Ok'])
      Else
        fMensagem('', 'A Classificação Tributária não é compatível com a CST.', ['&Ok']);
      edtCodClaTribEnt.Text := '';
      Result := False;
    End;
  End
  Else if Pos(Sender.Name, 'edtTriRegSaida_edtCrePreSaida_edtTriRegEntrada_edtCrePreEntrada') > 0 then
  Begin
    If Pos(TEditFocus(Sender).Text, 'S_N_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'No campo '+IIF(Pos('edtTriReg', Sender.Name) > 0,
                                            '"Enviar Grupo de Tributação Regular no XML"',
                                            '"Enviar Grupo de Crédito Presumido no XML"') + ' deve ser informado (S)im ou (N)ão!', ['&Ok']);
      Result := False;
    End
  End
  Else if Pos(Sender.Name, 'mskCfopSaida_mskCfopEntrada_') > 0 then
  begin
    if fEmptyStr(fRemoveCaracteres(TMaskEditFocus(Sender).Text, ' -')) then
    begin
      fMensagem('', 'O campo CFOP deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else if fTemCfopComMenosDe4Digitos(TMaskEditFocus(Sender).Text) then
    begin
      fMensagem('', 'Cada CFOP deve conter ao menos 4 dígitos. Verifique!', ['&Ok']);
      Result := False;
    end

  end;

  If (Result) Then
  Begin
    pCalculaTotalIBS(True);
    pCalculaTotalIBS(False);
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAbfReformaTributaria.ExisteConflito(const Lista: TArray<TCstCfop>; const Novo: TCstCfop): string;
var
  NovosCfopes, CFOPSExistente: string;
  ArrNovo, ArrExistente: TArray<string>;
  Item: TCstCfop;
  x,y: integer;
  intQtd: Integer;
begin
  Result := '';
  intQtd := 0;
  NovosCfopes := StringReplace(Novo.Cfops, ' ', '', [rfReplaceAll]);
  NovosCfopes := StringReplace(NovosCfopes, '--', '', [rfReplaceAll]);
  ArrNovo := NovosCfopes.Split(['-']);

  for Item in Lista do
  begin
    if Item.AutInc = Novo.AutInc then
      Continue; // pode atualizar o mesmo CST
    CFOPSExistente := StringReplace(Item.Cfops, ' ', '', [rfReplaceAll]);
    CFOPSExistente := StringReplace(CFOPSExistente, '--', '', [rfReplaceAll]);
    ArrExistente := CFOPSExistente.Split(['-']);
    for x := 0 to High(ArrNovo) do
    begin
      for y := 0 to High(ArrExistente) do
      begin
        if ArrNovo[x] = ArrExistente[y] then
        begin
          Result := Result + Format('O CFOP %s já está cadastrado para CST %s / ClassTrib %s', [ArrNovo[x], item.cst, item.ClassTrib]) + sLineBreak;

          Inc(intQtd);

          if intQtd = 3 then
            Exit;
        end;
      end;
    end;
  end;
end;

function TfrmCadAbfReformaTributaria.fAbreviacaoExiste: boolean;
begin
  FqryConsulta.SQL.Text := 'SELECT COUNT(1) QTD FROM ABFRTE WHERE RTE_CODABF = "'+edtCodApc.Text+'"';
  FqryConsulta.Open;
  Result := (FqryConsulta.FieldByName('QTD').AsInteger > 0);
end;

function TfrmCadAbfReformaTributaria.fCfopValidos(AListaGrupos: TStringList; AOperacaoSaida: Boolean): Boolean;
var lErro: string;
    i: integer;
begin
  Result := True;
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT NAT_CODCFO FROM NATCFO');
  FQryConsulta.Open;
  lErro := '';
  For i := 0 To AListaGrupos.Count - 1 do
  begin
    FQryConsulta.First;
    If not FQryConsulta.Locate('NAT_CODCFO', AListaGrupos[i], []) then
      lErro := lErro + IIf(lErro = '', '', ',') + AListaGrupos[i];
  End;

  If not lErro.IsEmpty then
  begin
    Result := False;
    pMensagemOk('CFOP''''s inválidos: ' + #13 + lErro);
    If AOperacaoSaida then
      pSetFocus(mskCfopSaida)
    Else
      pSetFocus(mskCfopEntrada)
  end;
end;

function TfrmCadAbfReformaTributaria.fGravaAbreviacao: Boolean;
var
  QryComandInsert: TUniQuery;
  QryComandUpdate: TUniQuery;
  objFotAntes: TFotoAbf;
  objFotDepois: TFotoAbf;
const
  SQLInsert = 'INSERT INTO ABFRTE (AUTOINCREM, RTE_CODABF, RTE_DESABF, RTE_CLAFIS, ' +
              'RTE_CODCLA, RTE_ENTSAI, RTE_CODCST, RTE_CBSALQ, RTE_CBSDIF, RTE_CBSRED, '+
              'RTE_IBSUFA, RTE_IBSUFD, RTE_IBSUFR, RTE_TRIREG, RTE_CREPRE '+
              ') VALUES ' +
              '(:AUTOINCREM, :RTE_CODABF, :RTE_DESABF, :RTE_CLAFIS, ' +
              ':RTE_CODCLA, :RTE_ENTSAI, :RTE_CODCST, :RTE_CBSALQ, :RTE_CBSDIF, :RTE_CBSRED, '+
              ':RTE_IBSUFA, :RTE_IBSUFD, :RTE_IBSUFR, :RTE_TRIREG, :RTE_CREPRE)';

  SQLUpdate = 'UPDATE ABFRTE SET ' +
              'RTE_DESABF = :RTE_DESABF, ' +
              'RTE_CLAFIS = :RTE_CLAFIS, ' +
              'RTE_CODCLA = :RTE_CODCLA, ' +
              'RTE_CODCST = :RTE_CODCST, ' +
              'RTE_CBSALQ = :RTE_CBSALQ, ' +
              'RTE_CBSDIF = :RTE_CBSDIF, ' +
              'RTE_CBSRED = :RTE_CBSRED, ' +
              'RTE_IBSUFA = :RTE_IBSUFA, ' +
              'RTE_IBSUFD = :RTE_IBSUFD, ' +
              'RTE_IBSUFR = :RTE_IBSUFR, ' +
              'RTE_TRIREG = :RTE_TRIREG, ' +
              'RTE_CREPRE = :RTE_CREPRE  ' +
              'WHERE AUTOINCREM = :AUTOINCREM';

  procedure ProcessarDataset(cds: TDataSet; EntradaSaida: Char);
  var
    sAutoIncrem: string;
  begin
    cds.First;
    while not cds.Eof do
    begin
      sAutoIncrem := cds.FieldByName('AUTOINCREM').AsString;
      If Length(sAutoIncrem) < 20 then
        sAutoIncrem := '';

      if fEmptyStr(sAutoIncrem) then
      begin
        // INSERT
        QryComandInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ABFRTE', VS_StrCodEmp);
        QryComandInsert.ParamByName('RTE_CODABF').AsString := edtCodApc.Text;
        QryComandInsert.ParamByName('RTE_DESABF').AsString := edtDescri.Text;
        QryComandInsert.ParamByName('RTE_CLAFIS').AsString := StringReplace(cds.FieldByName('CFOPS').AsString, '-' , '', [rfReplaceAll]);
        QryComandInsert.ParamByName('RTE_CODCLA').AsString := cds.FieldByName('CLATRIB').AsString;
        QryComandInsert.ParamByName('RTE_ENTSAI').AsString := EntradaSaida;
        QryComandInsert.ParamByName('RTE_CODCST').AsString := cds.FieldByName('CST').AsString;
        QryComandInsert.ParamByName('RTE_CBSALQ').AsFloat := cds.FieldByName('CBSALQ').AsFloat;
        QryComandInsert.ParamByName('RTE_CBSDIF').AsFloat := cds.FieldByName('CBSDIF').AsFloat;
        QryComandInsert.ParamByName('RTE_CBSRED').AsFloat := cds.FieldByName('CBSRED').AsFloat;
        QryComandInsert.ParamByName('RTE_IBSUFA').AsFloat := cds.FieldByName('IBSUFA').AsFloat;
        QryComandInsert.ParamByName('RTE_IBSUFD').AsFloat := cds.FieldByName('IBSUFD').AsFloat;
        QryComandInsert.ParamByName('RTE_IBSUFR').AsFloat := cds.FieldByName('IBSUFR').AsFloat;
        QryComandInsert.ParamByName('RTE_TRIREG').AsString := IIF(cds.FieldByName('TRIREG').AsString = 'SIM', 'S', 'N');
        QryComandInsert.ParamByName('RTE_CREPRE').AsString := IIF(cds.FieldByName('CREPRE').AsString = 'SIM', 'S', 'N');
        QryComandInsert.Execute;
      end
      else
      begin
        // UPDATE
        QryComandUpdate.ParamByName('RTE_DESABF').AsString := edtDescri.Text;
        QryComandUpdate.ParamByName('RTE_CLAFIS').AsString := StringReplace(cds.FieldByName('CFOPS').AsString, '-' , '', [rfReplaceAll]);
        QryComandUpdate.ParamByName('RTE_CODCLA').AsString := cds.FieldByName('CLATRIB').AsString;
        QryComandUpdate.ParamByName('RTE_CODCST').AsString := cds.FieldByName('CST').AsString;
        QryComandUpdate.ParamByName('RTE_CBSALQ').AsFloat := cds.FieldByName('CBSALQ').AsFloat;
        QryComandUpdate.ParamByName('RTE_CBSDIF').AsFloat := cds.FieldByName('CBSDIF').AsFloat;
        QryComandUpdate.ParamByName('RTE_CBSRED').AsFloat := cds.FieldByName('CBSRED').AsFloat;
        QryComandUpdate.ParamByName('RTE_IBSUFA').AsFloat := cds.FieldByName('IBSUFA').AsFloat;
        QryComandUpdate.ParamByName('RTE_IBSUFD').AsFloat := cds.FieldByName('IBSUFD').AsFloat;
        QryComandUpdate.ParamByName('RTE_IBSUFR').AsFloat := cds.FieldByName('IBSUFR').AsFloat;
        QryComandUpdate.ParamByName('RTE_TRIREG').AsString := IIF(cds.FieldByName('TRIREG').AsString = 'SIM', 'S', 'N');
        QryComandUpdate.ParamByName('RTE_CREPRE').AsString := IIF(cds.FieldByName('CREPRE').AsString = 'SIM', 'S', 'N');
        QryComandUpdate.ParamByName('AUTOINCREM').AsString := sAutoIncrem;

        QryComandUpdate.Execute;
      end;

      cds.Next;
      pbProgresso.Position := pbProgresso.Position + 1;
      Application.ProcessMessages;

    end;
  end;

begin
  if (cdsSaida.IsEmpty) or (cdsEntrada.IsEmpty) then
  begin
    fMensagem('Atenção!', 'É necessário informar regras para entrada e saída!', ['&Ok']);
    Exit(False);
  end;

  pnlProgresso.Visible := True;
  pbProgresso.Properties.Max := cdsSaida.RecordCount +  cdsEntrada.RecordCount;
  QryComandInsert := fCriaQuery;
  QryComandUpdate := fCriaQuery;

  Try
    fHabilitarForeignKey(False);
    try

      QryComandInsert.SQL.Text := SQLInsert;
      QryComandUpdate.SQL.Text := SQLUpdate;

      fStartTransaction;
      objFotAntes := fFotoAbreviacao(edtCodApc.Text);
      Try
        ProcessarDataset(cdsSaida, 'S');
        ProcessarDataset(cdsEntrada, 'E');
        ApagaCSTs;

        objFotDepois := fFotoAbreviacao(edtCodApc.Text);
        Try
          pGravaLogAbreviacao(objFotAntes, objFotDepois, 'G');

          fCommit;
          Result := True;
          CarregaAbf(edtCodApc.Text);
          FListaExclusao.Clear;

          FCstCfopEditaSaida.pLimpa;
          FCstCfopEditaEntrada.pLimpa;
        Finally
          FreeAndNil(objFotDepois);
        End;
      Finally
        FreeAndNil(objFotAntes);
      End;
    except
      on E: Exception do
      begin
        Result := False;
        If fInTransaction Then
          fRollBack;
        pMensagensErro(e.message, '[TfrmCadAbfReformaTributaria.fGravaAbreviacao]');
      end;
    End;
  finally
    fHabilitarForeignKey(True);
    FreeAndNil(QryComandInsert);
    FreeAndNil(QryComandUpdate);
    pnlProgresso.Visible := False;
  end;
end;

function TfrmCadAbfReformaTributaria.fLocalizaCST(ACST: String; ASaida: Boolean = True): Boolean;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT DESCRICAO_CST_IBS_CB FROM CST_IBSCBS');
  FQryConsulta.SQL.Add('WHERE CST_IBS_CBS = "'+ACST+'"');
  FQryConsulta.Open;
  Result := (Not FQryConsulta.IsEmpty);

  If (Result) Then
    If (ASaida) Then
      edtDesCstSaida.Text := FQryConsulta.FieldByName('DESCRICAO_CST_IBS_CB').AsString
    Else
      edtDesCstEntrada.Text := FQryConsulta.FieldByName('DESCRICAO_CST_IBS_CB').AsString;
end;

function TfrmCadAbfReformaTributaria.fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery;
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SET FOREIGN_KEY_CHECKS=' + IIF(blnHabilitar, '1', '0'));
      qryAux.ExecSQL;
      qryAux.Close;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fHabilitarForeignKey]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadAbfReformaTributaria.fFotoAbreviacao(const ACodAbf: string): TFotoAbf;
  Var
    qryFoto: TUniQuery;
    lstCampos: TStringList;
    intCnt: Integer;

  function fValorCampo(const AField: TField): string;
  begin
    If AField.IsNull Then
      Result := ''
    Else If AField.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftExtended, ftSingle] Then
      Result := FormatFloat('0.00##', AField.AsFloat)
    Else
      Result := Trim(AField.AsString);
  end;

begin
  Result := TFotoAbf.Create([doOwnsValues]);
  Try
    qryFoto := fCriaQuery;
    Try
      qryFoto.SQL.Text := 'SELECT * FROM ABFRTE WHERE RTE_CODABF = :RTE_CODABF';
      qryFoto.ParamByName('RTE_CODABF').AsString := ACodAbf;
      qryFoto.Open;
      qryFoto.First;
      While Not qryFoto.Eof Do
      Begin
        lstCampos := TStringList.Create;
        Try
          For intCnt := 0 To qryFoto.FieldCount - 1 Do
            If Not SameText(qryFoto.Fields[intCnt].FieldName, 'AUTOINCREM') Then
              lstCampos.Add(UpperCase(qryFoto.Fields[intCnt].FieldName) + '=' + fValorCampo(qryFoto.Fields[intCnt]));
          Result.Add(qryFoto.FieldByName('AUTOINCREM').AsString, lstCampos);
        Except
          lstCampos.Free;
          Raise;
        End;
        qryFoto.Next;
      End;
    Finally
      FreeAndNil(qryFoto);
    End;
  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

procedure TfrmCadAbfReformaTributaria.pGravaLogAbreviacao(const AAntes, ADepois: TFotoAbf; const AOrigem: Char);
  const
    SQLInsertLog = 'INSERT INTO LOGRTE (AUTOINCREM, LOG_IDGRAV, LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_CODEMP, ' +
                   'LOG_NOMMAQ, LOG_CON_ID, LOG_ORIGEM, LOG_EVENTO, LOG_AUTRTE, LOG_CODABF, LOG_ENTSAI, ' +
                   'LOG_CODCST, LOG_CODCLA, LOG_NOMCAM, LOG_VALANT, LOG_VALATU) VALUES ' +
                   '(:AUTOINCREM, :LOG_IDGRAV, CURRENT_DATE, CURRENT_TIME, :LOG_CODOPE, :LOG_CODEMP, ' +
                   ':LOG_NOMMAQ, :LOG_CON_ID, :LOG_ORIGEM, :LOG_EVENTO, :LOG_AUTRTE, :LOG_CODABF, :LOG_ENTSAI, ' +
                   ':LOG_CODCST, :LOG_CODCLA, :LOG_NOMCAM, :LOG_VALANT, :LOG_VALATU)';
  Var
    lstLog: TList<TLogRte>;
    arrChaves: TArray<string>;
    strChave: string;
    lstAntes: TStringList;
    lstDepois: TStringList;
    intCnt: Integer;
    strAutLog: string;
    strIdGrav: string;
    qryLog: TUniQuery;
    recLog: TLogRte;

    function fFotoTexto(const ACampos: TStringList): string;
      var
        j: Integer;
    begin
      Result := '';
      For j := 0 To ACampos.Count - 1 Do
        Result := Result + ACampos.Names[j] + '=' + ACampos.ValueFromIndex[j] + ';';
    end;

    procedure pAdicionaLog(const AEvento, AAutRte: string; const ACampos: TStringList; const ANomCam, AValAnt, AValAtu: string);
      var
        recNovo: TLogRte;
    begin
      recNovo.Evento := AEvento;
      recNovo.AutRte := AAutRte;
      recNovo.CodAbf := ACampos.Values['RTE_CODABF'];
      recNovo.EntSai := ACampos.Values['RTE_ENTSAI'];
      recNovo.CodCst := ACampos.Values['RTE_CODCST'];
      recNovo.CodCla := ACampos.Values['RTE_CODCLA'];
      recNovo.NomCam := ANomCam;
      recNovo.ValAnt := AValAnt;
      recNovo.ValAtu := AValAtu;
      lstLog.Add(recNovo);
    end;

begin
  lstLog := TList<TLogRte>.Create;
  Try
    arrChaves := AAntes.Keys.ToArray;
    TArray.Sort<string>(arrChaves);
    For strChave In arrChaves Do
      If Not ADepois.ContainsKey(strChave) Then
        pAdicionaLog('D', strChave, AAntes[strChave], '*', fFotoTexto(AAntes[strChave]), '');

    arrChaves := ADepois.Keys.ToArray;
    TArray.Sort<string>(arrChaves);
    For strChave In arrChaves Do
    Begin
      lstDepois := ADepois[strChave];
      If Not AAntes.TryGetValue(strChave, lstAntes) Then
        pAdicionaLog('I', strChave, lstDepois, '*', '', fFotoTexto(lstDepois))
      Else
        For intCnt := 0 To lstDepois.Count - 1 Do
          If lstAntes.Values[lstDepois.Names[intCnt]] <> lstDepois.ValueFromIndex[intCnt] Then
            pAdicionaLog('A', strChave, lstDepois, lstDepois.Names[intCnt], lstAntes.Values[lstDepois.Names[intCnt]], lstDepois.ValueFromIndex[intCnt]);
    End;

    If lstLog.Count = 0 Then
      Exit;

    strAutLog := fRetAutoIncrem('LOGRTE', VS_strCodEmp, lstLog.Count);
    If fEmptyStr(strAutLog) Then
      Raise Exception.Create('Não foi possível gerar o código do log de alterações (LOGRTE).');
    strIdGrav := strAutLog;

    qryLog := fCriaQuery;
    Try
      qryLog.SQL.Text := SQLInsertLog;
      For recLog In lstLog Do
      Begin
        qryLog.ParamByName('AUTOINCREM').AsString := strAutLog;
        qryLog.ParamByName('LOG_IDGRAV').AsString := strIdGrav;
        qryLog.ParamByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
        qryLog.ParamByName('LOG_CODEMP').AsString := VS_strCodEmp;
        qryLog.ParamByName('LOG_NOMMAQ').AsString := VS_ComputerNetName;
        If fEmptyStr(VS_ConnectionID) Then
        Begin
          qryLog.ParamByName('LOG_CON_ID').DataType := ftString;
          qryLog.ParamByName('LOG_CON_ID').Clear;
        End
        Else
          qryLog.ParamByName('LOG_CON_ID').AsString := Trim(VS_ConnectionID);
        qryLog.ParamByName('LOG_ORIGEM').AsString := AOrigem;
        qryLog.ParamByName('LOG_EVENTO').AsString := recLog.Evento;
        qryLog.ParamByName('LOG_AUTRTE').AsString := recLog.AutRte;
        qryLog.ParamByName('LOG_CODABF').AsString := recLog.CodAbf;
        qryLog.ParamByName('LOG_ENTSAI').AsString := recLog.EntSai;
        qryLog.ParamByName('LOG_CODCST').AsString := recLog.CodCst;
        qryLog.ParamByName('LOG_CODCLA').AsString := recLog.CodCla;
        qryLog.ParamByName('LOG_NOMCAM').AsString := recLog.NomCam;
        qryLog.ParamByName('LOG_VALANT').AsString := recLog.ValAnt;
        qryLog.ParamByName('LOG_VALATU').AsString := recLog.ValAtu;
        qryLog.Execute;

        strAutLog := fNextAutoIncrem(strAutLog);
      End;
    Finally
      FreeAndNil(qryLog);
    End;
  Finally
    FreeAndNil(lstLog);
  End;
end;

{ TCstCfop }

procedure TCstCfop.pLimpa;
begin
  Cst := '';
  AutInc := '';
  Cfops := '';
  ClassTrib := '';
end;

{ TEditHelper }

procedure TEditHelper.SetValor(AValor: Double);
begin
  Self.Text := FormatFloat('0.00', AValor) + ' %';
end;

function TEditHelper.GetValor: Double;
var
  Texto: string;
begin
  Texto := StringReplace(Self.Text, '%', '', [rfReplaceAll]);
  Texto := Trim(Texto);
  Texto := StringReplace(Texto, '.', ',', [rfReplaceAll]);

  if not TryStrToFloat(Texto, Result) then
    Result := 0;
end;

end.
