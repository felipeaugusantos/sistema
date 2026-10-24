unit untCadSalNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts,
   DBComboBoxFocus, BitBtnLockedIncrem, Uni, UniClientDataSet, frxClass,
  frxExportCSVTestabilidade, untIDataSet, untTypesSistema, untMensagemTabela;

type
  TfrmCadSalNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeQtdC09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtdC10: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    dbeQtdC11: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    Label5: TLabel;
    dbeLinha_: TDBComboBoxFocus;
    Label3: TLabel;
    Label6: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    dbeQtdD11: TDBEditFocus;
    dbeQtdD12: TDBEditFocus;
    dbeQtdD13: TDBEditFocus;
    dbeQtdD14: TDBEditFocus;
    dbeQtdD15: TDBEditFocus;
    dbeQtdD16: TDBEditFocus;
    dbeQtdD17: TDBEditFocus;
    dbeQtdD18: TDBEditFocus;
    dbeQtdD19: TDBEditFocus;
    dbeQtdD20: TDBEditFocus;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    dbeQtdD01: TDBEditFocus;
    dbeQtdD02: TDBEditFocus;
    dbeQtdD03: TDBEditFocus;
    dbeQtdD04: TDBEditFocus;
    dbeQtdD05: TDBEditFocus;
    dbeQtdD06: TDBEditFocus;
    dbeQtdD07: TDBEditFocus;
    dbeQtdD08: TDBEditFocus;
    dbeQtdD09: TDBEditFocus;
    dbeQtdD10: TDBEditFocus;
    lblInformativo: TLabel;
    lblVolumeTotal: TLabel;
    btnAjustarVolume: TBitBtnLocked;
    btnAtivarNfm: TBitBtnLocked;
    dbchkAtivo: TDBCheckBox;
    Label65: TLabel;
    dbeAcrMob: TDBEditFocus;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnAtivarNfmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeLinha_Change(Sender: TObject);
    procedure btnAjustarVolumeClick(Sender: TObject);
    procedure dbeQtdC01Exit(Sender: TObject);

  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    cdsBases: TUniClientDataSet;
    fltTotalConcentrado: Double;
    fltTotalDiluido: Double;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pAtivarDesativarNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadTinta;
    procedure pBotaoAtivarNfm;
    function VerificarNovaFormulaMovimentada: Boolean;
    function fValidaBasesLinha: Boolean;
    function fValidaBaseLinha(const strBase, strLinha: string): Boolean;
    function fValidarQntConcDiluida: Boolean;
    function fValidarBasePreenchida: Boolean;

    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(): String;
    function FTemPedidoNfm(): Boolean;
    function fMensagemTabelas(strTitulo : String;
                           strTitCol   : String;
                           arrMensagem : TStringArray;
                           strTexto    : String;
                           arrOpcoes   : Array Of String;
                           intFocoBotao: Integer = 1;
                           blnSaiComEsc: Boolean = False;
                           intEstFon   : Integer = 1;
                           intWidBut   : Integer = 0;
                           blnAutosize : Boolean = False;
                           intSomarTop : Integer=0;
                           blnObrigaEsc: Boolean = False;
                           blnOcultPainelBtn: Boolean = False;
                           blnBtnSemImg: Boolean = False;
                           intHeightOpc: Integer = 0;
                           intHeightFrm: Integer = 0;
                           intWidthFrm: Integer = 0;
                           blnBtnOk: Boolean = False): Integer;

    procedure pInserirMascara;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    procedure pAtualizaNfm;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pCalcularTotalVolume;
    procedure Ajustar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmCadSalNovasFormulas: TfrmCadSalNovasFormulas;

implementation

uses
  untFuncTinta, untModuloTinta, untPai, untSalcomix,
  untIConfTinta, untFuncoesSimples, untSalcomixDinamica, untConsultas;

{$R *.dfm}

{ TfrmCadSalNovasForumulas }

function TfrmCadSalNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  pCalcularTotalVolume;

  If (Sender = dbeCodigo) Then
  Begin
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma base!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      Result := False;
    End
    else if not fValidaBasesLinha then
      Result := False;

  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Or
          (Sender = dbeForm11) Or
          (Sender = dbeForm12) Or
          (Sender = dbeForm13) Or
          (Sender = dbeForm14) Or
          (Sender = dbeForm15) Or
          (Sender = dbeForm16) Or
          (Sender = dbeForm17) Or
          (Sender = dbeForm18) Or
          (Sender = dbeForm19) Or
          (Sender = dbeForm20) Then
  Begin
    If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End
    else If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdD20)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      Result := False;
    End
    else if not fValidaBasesLinha then
      Result := False;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Or
          (Sender = dbeQtdC11) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC13) Or
          (Sender = dbeQtdC14) Or
          (Sender = dbeQtdC15) Or
          (Sender = dbeQtdC16) Or
          (Sender = dbeQtdC17) Or
          (Sender = dbeQtdC18) Or
          (Sender = dbeQtdC19) Or
          (Sender = dbeQtdC20) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End
    End;
      {Else If fStrToFloat(TEdit(Sender).Text) <= 0 Then
      Begin
        if fStrToFloat(TDBEditFocus(FindComponent('dbeQtdD' + strNumCol)).Text) <= 0 then
        begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
          Result := False;
        end;
      End;}
  End
  Else If (Sender = dbeLinha_) Then
  Begin
    If (fEmptyStr(dbeLinha_.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Linha deve ser preechida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeAcrMob) Then
  Begin
    If fEmptyStr(dbeAcrMob.Text) Then
    Begin
      dbeAcrMob.Field.AsFloat := 0.00;
    End
    Else If Not fEmptyStr(dbeAcrMob.Text) Then
    Begin
      If (fStrToFloat(dbeAcrMob.Text) < 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
      End;
    End;
  End;

  if not Result then
    pSetFocus(Sender);
end;

function TfrmCadSalNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SAL_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadSalNovasFormulas.pCalcularTotalVolume;
var
  intCont: Integer;
  dbeComponente: TDBEditFocus;
  dbeQtdCon: TDBEditFocus;
  dbeQtdDil: TDBEditFocus;
begin
  if fEmptyStr(dbeLinha_.Text) then
    Exit;

  fltTotalConcentrado := 0;
  fltTotalDiluido := 0;
  for intCont := 0 to ComponentCount - 1 do
  begin
    if LeftStr(Components[intCont].Name, 7) = 'dbeForm' then
    begin
      dbeComponente := TDBEditFocus(Components[intCont]);
      dbeQtdCon := TDBEditFocus(FindComponent('dbeQtdC' + RightStr(dbeComponente.Name, 2)));
      dbeQtdDil := TDBEditFocus(FindComponent('dbeQtdD' + RightStr(dbeComponente.Name, 2)));

      if cdsBases.FindKey([dbeComponente.Text, dbeLinha_.Text]) then
      begin
        fltTotalConcentrado := fltTotalConcentrado + (fStrToFloat(dbeQtdCon.Text) / fStrToFloat(cdsBases.FieldByName('BAS_PESBAS').AsString));
        fltTotalDiluido := fltTotalDiluido + (fStrToFloat(dbeQtdDil.Text) / fStrToFloat(cdsBases.FieldByName('BAS_PESBAS').AsString));
      end;
    end;
  end;

  lblVolumeTotal.Caption := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);    
end;

procedure TfrmCadSalNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM SAL_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';
  qryCadNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';
  qryCadNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadSalNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadSalNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBComboBoxFocus) Then
    Begin
      (Components[intCont] as TDBComboBoxFocus).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodigo.DataField := 'NFM_CODNFM';
  dbeLinha_.DataField := 'NFM_LINHA_';
  dbeDtaCad.DataField := 'NFM_DTACAD';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeAcrMob.DataField := 'NFM_ACRMOB';

  For intCont := 1 To 20 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdD' + fStrZero(intCont, 2))).DataField := 'NFM_QTDD' + fStrZero(intCont, 2);
  End;
end;

function TfrmCadSalNovasFormulas.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := fCfgSis('ALTNFM') = 'S';
end;

function TfrmCadSalNovasFormulas.FTemPedidoNfm: Boolean;
var
  qryGen: TUniQuery;
  arrMensagem: TStringArray;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Text :=
    '  SELECT                            ' +
    '    T.FDO_DTAENT AS EMISSAO,        ' +
    '    CONCAT(T.FDO_NUMDOC, "-", T.FDO_ESPDOC, "-", T.FDO_CODEMP) AS PEDIDO,     ' +
    '    CONCAT(T.FDO_CODCLI, "-", IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI.CLI_NOMCLI, FGO_NOMCON)) AS CLIENTE,   ' +
    '    T.FDO_IDEPRO AS IDEPRO,         ' +
    '    T.FDO_DESCRI AS DESCRICAO,      ' +
    '    T.FDO_QTDITE AS QUANTIDADE,     ' +
    '    F.FDO_JAFATU AS FATURADO        ' +
    '  FROM                              ' +
    '    TINDOR T                        ' +
    '  INNER JOIN TINGOR AS GOR ON       ' +
    '    GOR.AUTOINCREM = T.FDO_SEQGER         ' +
    '  INNER JOIN CADOPE AS VEN ON       ' +
    '    T.FDO_CODVEN = VEN.OPE_CODOPE         ' +
    '  INNER JOIN CADOPE AS DIG ON       ' +
    '    T.FDO_CODDIG = DIG.OPE_CODOPE         ' +
    '  INNER JOIN CADCLI AS CLI ON       ' +
    '    T.FDO_CODCLI = CLI.CLI_CODCLI         ' +
    '  INNER JOIN FATDOR AS F ON         ' +
    '    F.FDO_NUMDOC = T.FDO_NUMDOC AND       ' +
    '    F.FDO_ESPDOC = T.FDO_ESPDOC AND       ' +
    '    F.FDO_CODEMP = T.FDO_CODEMP AND       ' +
    '    F.FDO_CODCLI = T.FDO_CODCLI AND       ' +
    '    F.FDO_CODACA = T.FDO_CODACA AND       ' +
    '    F.FDO_EMPACA = T.FDO_EMPACA           ' +
    '  LEFT JOIN EXTGOR AS EXT ON        ' +
    '    EXT.FGO_SEQFGO = F.AUTOINCREM         ' +
    '  WHERE                             ' +
    '    T.FDO_ITETIN = :ITETIN  AND           ' +
    '    T.FDO_ESPDOC = :ESPDOC  AND           ' +
    '    F.FDO_JAFATU = :JAFATU  AND           ' +
    '    T.FDO_IDEPRO = :IDEPRO                ' ;

    qryGen.ParamByName('ITETIN').AsString := fGetMd5KeyPedidos();
    qryGen.ParamByName('ESPDOC').AsString := 'PD';
    qryGen.ParamByName('JAFATU').AsString := '0';
    qryGen.ParamByName('IDEPRO').AsString := 'SAL';
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    Result := Not qryGen.IsEmpty;

    pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a susbtituição da tinta no pedido antes de faturá-lo.');
    pAddDados(arrMensagem, 'Segue pedidos em aberto com esta formulação:');
    pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');
    pAddDados(arrMensagem, 'DT.EMISSAO | PEDIDO              | CLIENTE                                | IDEPRO | DESCRIÇÃO                                                     | QUANTIDADE ');
    pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      pAddDados(arrMensagem,
                           fPadL(DateToStr(qryGen.FieldByName('EMISSAO').AsDateTime), 10) + ' | ' +
                           fPadL(qryGen.FieldByName('PEDIDO').AsString, 19) + ' | ' +
                           fPadR(qryGen.FieldByName('CLIENTE').AsString, 38) + ' |' +
                           fPadC(qryGen.FieldByName('IDEPRO').AsString, 6) + '  | ' +
                           fPadR(qryGen.FieldByName('DESCRICAO').AsString, 61) + ' | ' +
                           fPadL(FormatFloat('0.0000', qryGen.FieldByName('QUANTIDADE').AsFloat), 10));
      qryGen.Next;
    End;

    pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    If (Result) Then
    Begin
      If (fMensagemTabelas('ATENÇÃO!', 'Existem pedidos de venda em aberto utilizando esta formulação', arrMensagem, 'Deseja Continuar?', ['&Continuar', '&Voltar']) = 2) Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  Except
    On E: Exception Do
      Raise;
  End;
end;

function TfrmCadSalNovasFormulas.fValidaBaseLinha(const strBase, strLinha: string): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   SAL_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_LINHA_ = :LINHA  ';
      qryGen.ParamByName('CODBAS').AsString := strBase;
      qryGen.ParamByName('LINHA').AsString := strLinha;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

function TfrmCadSalNovasFormulas.fValidaBasesLinha: Boolean;
var
  intCont: Integer;
  edtAtual: TDBEditFocus;
begin
  Result := False;
  Try
    Try
      if fEmptyStr(dbeLinha_.Text) then
      begin
        fMensagem('ATENÇÃO', 'A linha deve ser preenchida!', ['OK']);
        Exit;
      end;

      for intCont := 0 to ComponentCount - 1 do
      begin
        if LeftStr(Components[intCont].Name, 7) = 'dbeForm' then
        begin
          edtAtual := TDBEditFocus(Components[intCont]);
          if not fEmptyStr(edtAtual.Text) then
          begin
            if not fValidaBaseLinha(edtAtual.Text, dbeLinha_.Text) then
            begin
              fMensagem('ATENÇÃO', Format('A base [%s] não está cadastrada para a linha [%s]', [edtAtual.Text, dbeLinha_.Text]), ['OK']);
              Exit;
            end;
          end;
        end;
      end;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;


end;

procedure TfrmCadSalNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'SAL_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
end;

procedure TfrmCadSalNovasFormulas.FormShow(Sender: TObject);
begin
  inherited;
  pBotaoAtivarNfm;
end;

procedure TfrmCadSalNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pInserirMascara;

  blnUsaProCodigo := False;
  dbeCodigo.Enabled := False;
//  pSetFocus(dbeDescri);
  pSetFocus(dbeLinha_);
  dbeDtaCad.Field.AsDateTime := Date;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);

  qryTabela.FieldByName('NFM_ATIVO_').AsString := 'S';
end;

procedure TfrmCadSalNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conSal, Nil, qryTabela, key, arrSel) Then
  Begin
    pCalcularTotalVolume;
    btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
    pBotaoAtivarNfm;
    pSetFocus(btnAlterar);
  End;

end;

constructor TfrmCadSalNovasFormulas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  cdsBases := fGeTUniClientDataSet(
    ' SELECT         ' +
    '   BAS_CODBAS   ' +
    '   , BAS_PESBAS ' +
    '   , BAS_LINHA_ ' +
    ' FROM           ' +
    '   SAL_CADBAS   ', 'BAS_CODBAS;BAS_LINHA_', True);
end;

procedure TfrmCadSalNovasFormulas.Ajustar;
var
  intCont: Integer;
  dbeComponente: TDBEditFocus;
  dbeQtdCon: TDBEditFocus;
  dbeQtdDil: TDBEditFocus;
begin
  pCalcularTotalVolume;
  
  if fEmptyStr(dbeLinha_.Text) then
    Exit;

  for intCont := 0 to ComponentCount - 1 do
  begin
    if LeftStr(Components[intCont].Name, 7) = 'dbeForm' then
    begin
      dbeComponente := TDBEditFocus(Components[intCont]);
      dbeQtdCon := TDBEditFocus(FindComponent('dbeQtdC' + RightStr(dbeComponente.Name, 2)));
      dbeQtdDil := TDBEditFocus(FindComponent('dbeQtdD' + RightStr(dbeComponente.Name, 2)));

      if cdsBases.FindKey([dbeComponente.Text, dbeLinha_.Text]) then
      begin
        if fltTotalConcentrado > 0 then
          dbeQtdCon.Field.AsFloat := dbeQtdCon.Field.AsFloat * 1000 / fltTotalConcentrado;

        if fltTotalDiluido > 0 then
          dbeQtdDil.Field.AsFloat := dbeQtdDil.Field.AsFloat * 1000 / fltTotalDiluido;
      end;
    end;
  end;

  pCalcularTotalVolume;
end;

procedure TfrmCadSalNovasFormulas.btnAjustarVolumeClick(Sender: TObject);
begin
  inherited;
  Ajustar;
end;

procedure TfrmCadSalNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
      Exit;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Exit;
    End;
  end;

  inherited;

  if (qryTabela.State = dsEdit) then
    pInserirMascara;

  dbeCodigo.Enabled := False;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);

  pCalcularTotalVolume;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
end;

procedure TfrmCadSalNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    blnGravouNfm: Boolean;
    conf: IConfTinta;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if fValidarQntConcDiluida then
  begin
    fMensagem('ATENÇÃO!', 'Existe base preenchida sem quantidade informada!', ['&Ok']);
    Exit;
  end;

  if fValidarBasePreenchida then
  begin
    fMensagem('ATENÇÃO!', 'Alguma quantidade "concentrada" ou "diluída" foi preenchida sem que a "base" fosse informada!', ['&Ok']);
    Exit;
  end;

  pCalcularTotalVolume;

  conf      := fGetConfTinta('SAL');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMSAL');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;

  Try
    inherited;

    If (blnGravou) Then
    Begin
      blnGravouNfm := fGeraNovasFormulasDinamica(qryTabela);

      If (blnGravouNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMSAL', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      blnGravou := False;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
end;

procedure TfrmCadSalNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCalcularTotalVolume;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
  pBotaoAtivarNfm;
end;

procedure TfrmCadSalNovasFormulas.btnAtivarNfmClick(Sender: TObject);
begin
  If fMensagem('QUESTÃO', 'Deseja realmente ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
  Begin
    pAtivarDesativarNfm;
    pAtualizaNfm;
  End;

  btnAtivarNfm.Caption := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
end;

procedure TfrmCadSalNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;
  
  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;

  Try
    inherited;

    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      blnExcluiu := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadSalNovasFormulas.btnExcluirClick]');
    End;
  End;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);

end;

procedure TfrmCadSalNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conSal, TDBEditFocus(Sender), nil, nil, Key, arrSel) Then
      If (fValidaCampos(TDBEditFocus(Sender))) Then
        Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadSalNovasFormulas.dbeLinha_Change(Sender: TObject);
begin
  utcRegistros.Limpar(Self.Name + 'SAL_CADBAS');
end;

procedure TfrmCadSalNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;
  if fEmptyStr((Sender as TDBEditFocus).Text) Then
    (Sender as TDBEditFocus).Text := '0,000';
end;

destructor TfrmCadSalNovasFormulas.Destroy;
begin
  if Assigned(cdsBases) then FreeAndNil(cdsBases);
  inherited;
end;

function TfrmCadSalNovasFormulas.fGetMd5KeyPedidos: String;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text :=
  '   SELECT * FROM SAL_CADSAL        ' +
  '  WHERE SAL_CODPRO = :CODIGO       ';
  qryGen.ParamByName('CODIGO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('SAL_MD5KEY').AsString;
end;

function TfrmCadSalNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;
end;

function TfrmCadSalNovasFormulas.fMensagemTabelas(strTitulo, strTitCol: String;
  arrMensagem: TStringArray; strTexto: String; arrOpcoes: array of String;
  intFocoBotao: Integer; blnSaiComEsc: Boolean; intEstFon, intWidBut: Integer;
  blnAutosize: Boolean; intSomarTop: Integer; blnObrigaEsc, blnOcultPainelBtn,
  blnBtnSemImg: Boolean; intHeightOpc, intHeightFrm, intWidthFrm: Integer;
  blnBtnOk: Boolean): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
    frmMsgTbl    : TfrmMensagemTabela;
begin
  intQtdOpcoes   := 0;
  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  Begin
    If arrOpcoes[intPosicao] <> '' Then
      Inc(intQtdOpcoes)
    Else
      Break;
  End;

  If (intFocoBotao <= 0) Or (intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  Try
    pCriarFormularios(TfrmMensagemTabela, frmMsgTbl);

    With frmMsgTbl Do
    Begin
      If Assigned(arrMensagem) then
        arrMensag := arrMensagem;

      strDesCol  := strTitCol;
      intSomaTop := intSomarTop;

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;
      Width := 1160;
      Height := 400;
      lsvTabela.Columns[0].Width := 1135;

      If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 450;
          Top        := 05;
          Height     := 28;
          Width      := 130;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 580;
          Top        := 05;
          Height     := 28;
          Width      := 130;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        end;
      End;
    End;

    frmMsgTbl.intFocus     := intFocoBotao;
    frmMsgTbl.blnSaiComEsc := blnSaiComEsc;
    frmMsgTbl.blnObrigaEsc := blnObrigaEsc;
    frmMsgTbl.blnOcultPainelBtn := blnOcultPainelBtn;

    frmMsgTbl.ShowModal;
    Result := frmMsgTbl.intRetorno;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fMensagemTabelas]');
    End;
  End;

  pFreeAndNil(frmMsgTbl);
  FreeAndNil(fntFonte);
end;

procedure TfrmCadSalNovasFormulas.pAtivaCadTinta;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE SAL_CADSAL ');
      SQL.Add('    SET SAL_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE SAL_CODPRO = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadSalNovasFormulas.pAtivaNfm;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE SAL_CADNFM ');
      SQL.Add('    SET NFM_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE NFM_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadSalNovasFormulas.pAtivarDesativarNfm;
begin
  Try
    fStartTransaction;

    pAtivaNfm;
    pAtivaCadTinta;

    fCommit;

    fMensagem('ATENÇÃO!', 'Nova Fórmula ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Erro na hora de ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Ativada','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TfrmCadSalNovasFormulas.pAtualizaNfm;
begin
  qryTabela.SQL.Text := qryTabela.SQL.Text;
  qryTabela.Open;
end;

procedure TfrmCadSalNovasFormulas.pBotaoAtivarNfm;
begin
  btnAtivarNfm.Enabled   := False;
  If Not qryTabela.IsEmpty Then
  Begin
    btnAtivarNfm.Enabled := VerificarNovaFormulaMovimentada;
    btnAtivarNfm.Caption := IIF(btnAtivarNfm.Enabled,
                            IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;

function TfrmCadSalNovasFormulas.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD     ' +
                                                 '  FROM %0:s                ' +
                                                 ' INNER JOIN SAL_CADSAL ON %1:s_ITETIN = SAL_MD5KEY ' +
                                                 ' WHERE %1:s_IDEPRO = "SAL" ' +
                                                 '   AND SAL_CODPRO = :CODNFM',
        [qryTabela.FieldByName('NFM_CODNFM').AsString]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TfrmCadSalNovasFormulas.fValidarBasePreenchida: Boolean;
begin
  result  := false;

  if (dbeForm01.text = '') and ((dbeQtdC01.text <> '0,000') or (dbeQtdD01.text <> '0,000')) then result  := true;
  if (dbeForm02.text = '') and ((dbeQtdC02.text <> '0,000') or (dbeQtdD02.text <> '0,000')) then result  := true;
  if (dbeForm03.text = '') and ((dbeQtdC03.text <> '0,000') or (dbeQtdD03.text <> '0,000')) then result  := true;
  if (dbeForm04.text = '') and ((dbeQtdC04.text <> '0,000') or (dbeQtdD04.text <> '0,000')) then result  := true;
  if (dbeForm05.text = '') and ((dbeQtdC05.text <> '0,000') or (dbeQtdD05.text <> '0,000')) then result  := true;
  if (dbeForm06.text = '') and ((dbeQtdC06.text <> '0,000') or (dbeQtdD06.text <> '0,000')) then result  := true;
  if (dbeForm07.text = '') and ((dbeQtdC07.text <> '0,000') or (dbeQtdD07.text <> '0,000')) then result  := true;
  if (dbeForm08.text = '') and ((dbeQtdC08.text <> '0,000') or (dbeQtdD08.text <> '0,000')) then result  := true;
  if (dbeForm09.text = '') and ((dbeQtdC09.text <> '0,000') or (dbeQtdD09.text <> '0,000')) then result  := true;
  if (dbeForm10.text = '') and ((dbeQtdC10.text <> '0,000') or (dbeQtdD10.text <> '0,000')) then result  := true;
  if (dbeForm11.text = '') and ((dbeQtdC11.text <> '0,000') or (dbeQtdD11.text <> '0,000')) then result  := true;
  if (dbeForm12.text = '') and ((dbeQtdC12.text <> '0,000') or (dbeQtdD12.text <> '0,000')) then result  := true;
  if (dbeForm13.text = '') and ((dbeQtdC13.text <> '0,000') or (dbeQtdD13.text <> '0,000')) then result  := true;
  if (dbeForm14.text = '') and ((dbeQtdC14.text <> '0,000') or (dbeQtdD14.text <> '0,000')) then result  := true;
  if (dbeForm15.text = '') and ((dbeQtdC15.text <> '0,000') or (dbeQtdD15.text <> '0,000')) then result  := true;
  if (dbeForm16.text = '') and ((dbeQtdC16.text <> '0,000') or (dbeQtdD16.text <> '0,000')) then result  := true;
  if (dbeForm17.text = '') and ((dbeQtdC17.text <> '0,000') or (dbeQtdD17.text <> '0,000')) then result  := true;
  if (dbeForm18.text = '') and ((dbeQtdC18.text <> '0,000') or (dbeQtdD18.text <> '0,000')) then result  := true;
  if (dbeForm19.text = '') and ((dbeQtdC19.text <> '0,000') or (dbeQtdD19.text <> '0,000')) then result  := true;
  if (dbeForm20.text = '') and ((dbeQtdC20.text <> '0,000') or (dbeQtdD20.text <> '0,000')) then result  := true;
end;


function TfrmCadSalNovasFormulas.fValidarQntConcDiluida: Boolean;
begin
  result  := false;

  if (dbeForm01.text <> '') and (dbeQtdC01.text = '0,000') and (dbeQtdD01.text = '0,000') then result  := true;
  if (dbeForm02.text <> '') and (dbeQtdC02.text = '0,000') and (dbeQtdD02.text = '0,000') then result  := true;
  if (dbeForm03.text <> '') and (dbeQtdC03.text = '0,000') and (dbeQtdD03.text = '0,000') then result  := true;
  if (dbeForm04.text <> '') and (dbeQtdC04.text = '0,000') and (dbeQtdD04.text = '0,000') then result  := true;
  if (dbeForm05.text <> '') and (dbeQtdC05.text = '0,000') and (dbeQtdD05.text = '0,000') then result  := true;
  if (dbeForm06.text <> '') and (dbeQtdC06.text = '0,000') and (dbeQtdD06.text = '0,000') then result  := true;
  if (dbeForm07.text <> '') and (dbeQtdC07.text = '0,000') and (dbeQtdD07.text = '0,000') then result  := true;
  if (dbeForm08.text <> '') and (dbeQtdC08.text = '0,000') and (dbeQtdD08.text = '0,000') then result  := true;
  if (dbeForm09.text <> '') and (dbeQtdC09.text = '0,000') and (dbeQtdD09.text = '0,000') then result  := true;
  if (dbeForm10.text <> '') and (dbeQtdC10.text = '0,000') and (dbeQtdD10.text = '0,000') then result  := true;
  if (dbeForm11.text <> '') and (dbeQtdC11.text = '0,000') and (dbeQtdD11.text = '0,000') then result  := true;
  if (dbeForm12.text <> '') and (dbeQtdC12.text = '0,000') and (dbeQtdD12.text = '0,000') then result  := true;
  if (dbeForm13.text <> '') and (dbeQtdC13.text = '0,000') and (dbeQtdD13.text = '0,000') then result  := true;
  if (dbeForm14.text <> '') and (dbeQtdC14.text = '0,000') and (dbeQtdD14.text = '0,000') then result  := true;
  if (dbeForm15.text <> '') and (dbeQtdC15.text = '0,000') and (dbeQtdD15.text = '0,000') then result  := true;
  if (dbeForm16.text <> '') and (dbeQtdC16.text = '0,000') and (dbeQtdD16.text = '0,000') then result  := true;
  if (dbeForm17.text <> '') and (dbeQtdC17.text = '0,000') and (dbeQtdD17.text = '0,000') then result  := true;
  if (dbeForm18.text <> '') and (dbeQtdC18.text = '0,000') and (dbeQtdD18.text = '0,000') then result  := true;
  if (dbeForm19.text <> '') and (dbeQtdC19.text = '0,000') and (dbeQtdD19.text = '0,000') then result  := true;
  if (dbeForm20.text <> '') and (dbeQtdC20.text = '0,000') and (dbeQtdD20.text = '0,000') then result  := true;
end;

procedure TfrmCadSalNovasFormulas.pInserirMascara;
var
  intContador : Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdC')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;

      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;

      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeAcrMob')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.00;
    End;
  End;
end;

initialization
  RegisterClass(TfrmCadSalNovasFormulas);
finalization
  UnRegisterClass(TfrmCadSalNovasFormulas);

end.

