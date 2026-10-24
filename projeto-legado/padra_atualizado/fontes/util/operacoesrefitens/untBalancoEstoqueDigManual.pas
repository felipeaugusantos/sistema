{******************************************************************************}
{* "VOS,FILHOS,SEDE OBEDIENTES A VOSSOS PAIS NO SENHOR,PORQUE ISTO E' JUSTO.  *}
{*  HONRA A TEU PAI E A TUA MÃE (QUE E' O PRIMEIRO MANDAMENTO COM PROMESSA),  *}
{*  PARA QUE TE VA' BEM, E SEJAS DE LONGA VIDA SOBRE A TERRA."                *}
{*                                                          (EFESIOS 6:1-3)   *}
{******************************************************************************}

unit untBalancoEstoqueDigManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, untCadLote, DBGridCitel, DBGrids, Grids,  strUtils, untBalancoEstrutura,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  untConsultas, untControleContagemBalancoEstoque, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox;

type
  TfrmBalancoEstoqueDigManual = class(TfrmPai)
    pnlProduto: TPanel;
    pnlSaldo: TPanel;
    Label4: TLabel;
    edtSldCon: TEditFocus;
    lblSldMl: TLabel;
    edtSldMl: TEditFocus;
    pnlSalLot: TPanel;
    pnlItens: TPanel;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    Panel1: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    lblSalGml: TLabel;
    Label6: TLabel;
    lblSalAml: TLabel;
    edtCodIte: TEditFocus;
    edtLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesUni: TEditFocus;
    edtSalCon: TEditFocus;
    edtSalGMl: TEditFocus;
    edtSalAtu: TEditFocus;
    edtSalAMl: TEditFocus;
    pnlLocFis: TPanel;
    Label8: TLabel;
    edtLocFis: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnFinalizaContagem: TBitBtnLocked;
    chkUsarInativos: TcxCheckBox;
    edtSalRes: TEditFocus;
    lblSalRes: TLabel;
    lblSalResVenSep: TLabel;
    edtSalResVenSep: TEditFocus;
    lblItemEstrutura: TLabel;
    pnlOper: TPanel;
    Label10: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSenDigEnter(Sender: TObject);
    procedure edtLocFisEnter(Sender: TObject);
    procedure btnFinalizaContagemClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);

  private
    blnReiniciando,
    blnControleContagem: Boolean;
    ControleContagemBalancoEstoque : TControleContagemBalancoEstoque;
    strCodAmz: String;

    blnConAcu,
    blnExiOpe: Boolean;

    intpnlSalLotHeight: Integer;
    objCadLot: TCadLot;
    qryConIte: TUniQuery;
    qryCadOpe: TUniQuery;
    qryConOpe: TUniQuery;
    intConEst: Integer;

    objBalancoEstrutura: TBalancoEstrutura;

    procedure pCarregaDigitador;
    procedure pCarregaProduto(Var blnEstrutura: Boolean);
    procedure pHabilitar;
    procedure pDesabilitar;

    Function fSalvaContagemEstrutura: Boolean;
    Function fCarregaSaldoReservado(strCodIte: String) : Double;
    function fEhEstrutura(AStrCodIte: String): Boolean;

    { Private declarations }
  public
    { Public declarations }
    strCodDig: String;
    strAutoSelLote: String;
    strOperCfg: String;

    Function fSalvaContagemManual(strCodIte: String;
      fltSalCon, fltSalMl: Double; intOrdCon: Integer; blnSavLog, blnImpLis: Boolean; strLocFis, strCodOpe: String): Boolean;

    procedure pMostraLote(blnMostrar: Boolean);
    procedure pCancelLote;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmBalancoEstoqueDigManual: TfrmBalancoEstoqueDigManual;

implementation

uses untFuncoesSimples,  DB,
     untBalancoEstoqueAjuste,untBalancoEstoqueDigManualLote, untBalancoEstoqueDigManualLista,
     untPesqAux, System.Types, untIFatEntregaFutura, untTFatEntregaFutura,
  untBalancoEstoqueManutencao;

{$R *.dfm}

procedure TfrmBalancoEstoqueDigManual.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);

  function fUsarBarraComoCaracter(Key: Char): Boolean;
  begin
    if (Key = '/') and (not fEmptyStr(edtCodIte.Text)) then
      Result := True
    else
      Result := False;
  end;
Var
  arrSel: TConsultasArray;
  varKey: Char;
  blnEstrutura: Boolean;
  blnBarraComoCaracter: Boolean;
begin
  inherited;

  blnBarraComoCaracter := fUsarBarraComoCaracter(Key);

  if blnBarraComoCaracter then
    varKey := #0
  else
    varKey := Key;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, varKey, arrSel, True, Nil, 'Consulta de Itens', '1') Then
  Begin

    pCarregaProduto(blnEstrutura);
    pHabilitar;
    Self.SelectNext(ActiveControl, True, True);

  End;

  if (not blnBarraComoCaracter) then
    Key := varKey;
end;

procedure TfrmBalancoEstoqueDigManual.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
Var
  arrCodOpe: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self,
                   edtCodOpe,
                   edtDesOpe,
                   Nil,
                   Key,
                   arrCodOpe ) Then
  Begin
    strOperCfg := edtCodOpe.text;
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueDigManual.edtLocFisEnter(Sender: TObject);
begin
  inherited;
  pDesabilitar;
end;

procedure TfrmBalancoEstoqueDigManual.edtSenDigEnter(Sender: TObject);
begin
  If blnReiniciando Then
    Exit;
  pDesabilitar;
  pMostraLote(False);
end;

function TfrmBalancoEstoqueDigManual.fCarregaSaldoReservado(strCodIte: String): Double;
var
  qryConsulta: TUniQuery;
  intDecQtd: integer;
begin
  qryConsulta := fCriaQuery(nil);

  try
    { CONSULTA SALDO RESERVADO }
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT SUM(EQU_QTDITE) AS QTDITE FROM EQUDET ');
    qryConsulta.SQL.Add('INNER JOIN EQUGER ON EQUGER.EQU_NUMOSE = EQUDET.EQU_NUMOSE ');
    qryConsulta.SQL.Add('WHERE EQU_CODITE = :CODITE AND EQUGER.EQU_CODEMP = :CODEMP AND EQUGER.EQU_STATUS = ''A''');
    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTDITE').AsFloat;

    lblSalRes.visible := qryConsulta.FieldByName('QTDITE').AsFloat > 0;
    edtSalRes.visible := qryConsulta.FieldByName('QTDITE').AsFloat > 0;

    intDecQtd := fCfgSis('DEQTAJ', varInteger);


    If TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS Then
      edtSalResVenSep.Text := FormatFloat(fMskDigitos(intDecQtd), TGerenciaBalancoEstoqueManutencao.fGetSaldoSeparadoConferido(strCodIte, VS_strCodEmp));


    qryConsulta.Close;

  finally
    pFreeAndNil(qryConsulta);
  end;
end;

procedure TfrmBalancoEstoqueDigManual.pCancelLote;
begin
  pMostraLote(False);
end;

procedure TfrmBalancoEstoqueDigManual.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryCadOpe, qryConOpe, edtSenDig.Text, True);
  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
    strCodDig      := FieldByName('OPE_CODOPE').AsString;
    frmBalancoEstoqueDigManualLista.strCodContador := strCodDig;

  End;
end;

procedure TfrmBalancoEstoqueDigManual.pCarregaProduto(Var blnEstrutura: Boolean);

  function pSplitLote(strCodDig: String; var strCodIte: String; var strCodLote: String): String;
  var
    arrString: TStringDynArray;
  begin
    strCodLote := '';
    strCodIte := strCodDig;

    arrString := SplitString(strCodDig, ' ');

    if Length(arrString) > 1 then
    begin
      strCodIte := arrString[0];
      strCodLote := strCodDig.Substring(Length(arrString[0])+1);
    end;
  end;

Var
  strSQL: String;
  strCodIte: String;
  intDecQtd: Integer;
  fltSaldos,
  fltSal_Ml: Double;

begin
  strAutoSelLote := '';

  blnEstrutura := False;

  If objBalancoEstrutura.fEhEtiquetaEstrutura(edtCodIte.Text) Then
  Begin
    blnEstrutura := True;
    fSalvaContagemEstrutura;
    Exit;
  End;

  intDecQtd := fCfgSis('DEQTAJ', varInteger);
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI", ';
  strSQL := strSQL + '  I.ITE_CODITE AS "ITE_CODITE", ';
  strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
  strSQL := strSQL + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "ITE_DESITE", ';
  strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
  strSQL := strSQL + '  U.UNI_DESUNI AS "UNI_DESUNI", ';
  strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
  strSQL := strSQL + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
  strSQL := strSQL + '  G.ITE_SALDOS AS "ITE_SALDOS", ';
  strSQL := strSQL + '  G.ITE_SALBAL AS "ITE_SALBAL", ';
  strSQL := strSQL + '  G.ITE_DTABAL AS "ITE_DTABAL", ';
  strSQL := strSQL + '  G.ITE_SAL_ML AS "ITE_SAL_ML", ';
  strSQL := strSQL + '  I.ITE_CNV_ML AS "ITE_CNV_ML", ';

  If blnControleContagem Then
  Begin
    strSQL := strSQL + '  IFNULL(BLD_QTDITE, 0) AS "ITE_SALCON", ';
    strSQL := strSQL + '  IFNULL(BLD_QTDGML, 0) AS "ITE_GMLCON", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_SALCON AS "ITE_SALCON", ';
    strSQL := strSQL + '  G.ITE_GMLCON AS "ITE_GMLCON", ';
  End;

  strSQL := strSQL + '  G.ITE_DIFSAL AS "ITE_DIFSAL", ';
  strSQL := strSQL + '  G.ITE_DIF_ML AS "ITE_DIF_ML"  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  INNER JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '  INNER JOIN CADFOR F ON I.ITE_CODFOR = F.FOR_CODFOR ';
  strSQL := strSQL + '  INNER JOIN CADGRU P ON I.ITE_CODGRU = P.GRU_CODGRU ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = :CODEMP ';

  If blnControleContagem Then
  Begin
    strSQL := strSQL + '   LEFT JOIN BALGER ON BLG_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '                   AND BLG_STATUS = "A"';
    strSQL := strSQL + '                   AND BLG_LOCFIS = ' + QuotedStr(edtLocFis.Text) ;
    strSQL := strSQL + '   LEFT JOIN BALDET ON BLD_SEQGER = BALGER.AUTOINCREM';
    strSQL := strSQL + '                   AND BLD_CODITE = G.ITE_CODITE';
    strSQL := strSQL + '                   AND BLD_STATUS = "A"';
    strSQL := strSQL + '                   AND BLD_CODOPE = ' + QuotedStr(strCodDig) ;
    strSQL := strSQL + ' ';
    strSQL := strSQL + ' ';
  End;

  strSQL := strSQL + 'WHERE ';

  pSplitLote(edtCodIte.Text, strCodIte, strAutoSelLote);

  edtCodIte.Text := fStrZero(strCodIte, fTamCodIte);

  If Length(edtCodIte.Text) <= fTamCodite Then
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE  '
  Else
    strSQL := strSQL + '  I.ITE_CODBAR = :CODITE  ';


  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := SplitString(edtCodIte.Text, '__')[0];
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    edtCodIte.Text    := FieldByName('ITE_CODITE').AsString;

    edtLinGru.Text := FieldByName('ITE_CODGRU').AsString + ' - ' +
                      FieldByName('GRU_DESGRU').AsString;

    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    edtRefere.Text := FieldByName('ITE_REFERE').AsString;

    edtDesUni.Text := FieldByName('ITE_CODUNI').AsString;

    edtDesMar.Text := FieldByName('ITE_CODMAR').AsString + ' - ' +
                      FieldByName('MAR_DESMAR').AsString;

    edtNomFor.Text := FieldByName('ITE_CODFOR').AsString + ' - ' +
                      FieldByName('FOR_NOMFOR').AsString;

    edtSalCon.Text := FormatFloat(fMskDigitos(3), FieldByName('ITE_SALCON').AsFloat);
    edtSalGml.Text := FormatFloat(fMskDigitos(3), FieldByName('ITE_GMLCON').AsFloat);

    If (Not fEmptyStr(strCodAmz)) And fExisteLote(FieldByName('ITE_CODITE').AsString, VS_strCodEmp) Then
    Begin
      TCadLot.pRetSaldosLoteArmazem(FieldByName('ITE_CODITE').AsString, TCadLot.fRetLotesContagemAberta, fltSaldos, fltSal_Ml);


      If fUsaQtdPendenteEntregaFutura Then
      Begin
        edtSalAtu.Text := FormatFloat(fMskDigitos(intDecQtd), fltSaldos  +
                                                   TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(edtCodIte.Text)
                                                       .CodEmp(VS_strCodEmp)
                                                       .Lotes(Concat(QuotedStr(strCodAmz), ',', TCadLot.fRetLotesContagemAberta))
                                                       .TipoTE(tteTodas)
                                                     ).Total());

        edtSalAMl.Text := FormatFloat(fMskDigitos(intDecQtd), fltSal_Ml  +
                                                   TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(edtCodIte.Text)
                                                       .CodEmp(VS_strCodEmp)
                                                       .Lotes(Concat(QuotedStr(strCodAmz), ',', TCadLot.fRetLotesContagemAberta))
                                                       .TipoTE(tteTodas)
                                                       .ConverteML(True)
                                                     ).Total());
      End
      Else
      Begin
        edtSalAtu.Text := FormatFloat(fMskDigitos(intDecQtd), fltSaldos);
        edtSalAMl.Text := FormatFloat(fMskDigitos(intDecQtd), fltSal_Ml);
      End;

    End Else
    Begin

      If fUsaQtdPendenteEntregaFutura Then
      Begin
        edtSalAtu.Text := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat  +
                                                 TEntregaFutura.New(
                                                   TParamEF.New()
                                                     .CodIte(edtCodIte.Text)
                                                     .CodEmp(VS_strCodEmp)
                                                     .TipoTE(tteTodas)
                                                   ).Total());

        edtSalAMl.Text := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SAL_ML').AsFloat  +
                                                 TEntregaFutura.New(
                                                   TParamEF.New()
                                                     .CodIte(edtCodIte.Text)
                                                     .CodEmp(VS_strCodEmp)
                                                     .TipoTE(tteTodas)
                                                     .ConverteML(True)
                                                   ).Total());
      End
      Else
      Begin
        edtSalAtu.Text := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat );
        edtSalAMl.Text := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SAL_ML').AsFloat);
      End;

    End;

//    edtSalAMl.Text := FormatFloat(fMskDigitos(3), FieldByName('ITE_SAL_ML').AsFloat);
    
    edtSldCon.Text := '0,000';
    edtSldMl.Text :=  '0,000';

    lblSldMl.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;
    edtSldMl.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;

    lblSalGml.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;
    edtSalGml.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;

    lblSalAml.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;
    edtSalAMl.Visible := FieldByName('ITE_CNV_ML').AsFloat > 0;

    edtSalRes.text := FormatFloat(fMskDigitos(intDecQtd),fCarregaSaldoReservado(FieldByName('ITE_CODITE').AsString));

  End;

  pMostraLote(fExisteLote(edtCodIte.Text, VS_strCodEmp));


end;

procedure TfrmBalancoEstoqueDigManual.FormCreate(Sender: TObject);
begin
  inherited;
  blnReiniciando := False;
  edtSalResVenSep.Visible := TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS;
  lblSalResVenSep.Visible := edtSalResVenSep.Visible;

  pCriarFormularios(TfrmBalancoEstoqueDigManualLista, frmBalancoEstoqueDigManualLista);

  objBalancoEstrutura := TBalancoEstrutura.Create(Self);

  qryConIte := fCriaQuery(Self);
  objCadLot := TCadLot.Create(Self);

  blnConAcu := fCfgSis('CONACU', varBoolean);
  blnControleContagem := TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;
  If not blnControleContagem Then
  Begin
    pnlProduto.Height := pnlProduto.Height - pnlLocFis.Height;
    pnlLocFis.Visible := blnControleContagem;
  End;
  ControleContagemBalancoEstoque := TControleContagemBalancoEstoque.Create;
  btnFinalizaContagem.Visible := blnControleContagem;

  strOperCfg := strLoginUsuarioLogado;
  blnExiOpe := fCfgSis('EXIOPE', varBoolean);
  pnlOper.Visible := blnExiOpe;
  If blnExiOpe Then
  Begin
    edtCodOpe.text  := strLoginUsuarioLogado;
    edtDesOpe.Text  := fRetNomVendRep(strLoginUsuarioLogado);
  End;
  If not blnExiOpe then
    pnlProduto.Height := pnlProduto.Height - pnlOper.Height;

  qryCadOpe := fCriaQuery(Self);
  qryConOpe := fCriaQuery(Self);

  intpnlSalLotHeight := pnlSalLot.Height;
  pCriarFormularios(TfrmBalancoEstoqueDigManualLote, frmBalancoEstoqueDigManualLote);
  frmBalancoEstoqueDigManualLote.objCadLot := objCadLot;
  frmBalancoEstoqueDigManualLote.frmBalancoEstoqueDigManual := Self;
  frmBalancoEstoqueDigManualLote.frmBalancoEstoqueDigManualLista := frmBalancoEstoqueDigManualLista;
end;

{************************}
{* VALIDACAO DE CAMPOS  *}
{*********************JC*}
function TfrmBalancoEstoqueDigManual.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnEstrutura: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {****************************}
    {* VALIDA SENHA DO OPERADOR *}
    {*************************RV*}
    If (Sender = edtSenDig) And (pnlDigitador.Enabled) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaDigitador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador está inativo!', ['&O k']);
          Result := False;
        End;
        If Result Then
          pnlDigitador.Enabled := False;
      End;
    End
    Else If (Sender = edtCodOpe) Then
    begin
      If Not fEmptyStr(edtCodOpe.Text) Then
      begin
        edtDesOpe.Text := fRetNomVendRep(edtCodOpe.Text);
        If fEmptyStr(edtDesOpe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador não encotrando!', ['&O k']);
          Result := False;
        End
        Else
          strOperCfg := edtCodOpe.Text;
      end;
    End
    Else If (Sender = edtCodIte) Then
    Begin

      {************************}
      {* VALIDACAO DE CODIGO  *}
      {*********************JC*}
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;

      End
      Else If blnControleContagem And ControleContagemBalancoEstoque.fContagemFinalizadaPara_o_Item(edtLocFis.Text, edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A contagem deste item já foi finalizada para esta localização fisica!', ['&O k']);
        edtCodIte.Text := '';
        Result := False;
      End
      Else
      Begin
        pCarregaProduto(blnEstrutura);
        lblItemEstrutura.Visible := fEhEstrutura(edtCodIte.Text);

        If blnEstrutura Then
        Begin
          blnMudarFoco := False;
          pSetFocus(edtCodIte);
        End Else
        Begin
          frmBalancoEstoqueDigManualLote.blnUsaCNV_ML := qryConIte.FieldByName('ITE_CNV_ML').AsFloat > 0;
          If qryConIte.FieldByName('ITE_CODITE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            if (strAutoSelLote <> '') and
              not (objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, strAutoSelLote)) then
            begin
              fMensagem('ATENÇÃO!', 'Lote informado não disponível!', ['&O k']);
              Result := False;

              pMostraLote(False);
              pDesabilitar;
            end
            else
            begin
              blnMudarFoco := False;
              pHabilitar;

              If Not pnlSalLot.Visible Then
                Self.SelectNext(ActiveControl, True, True);
            end;
          End;
        End;
      End;
    End

   {************************}
   {* VALIDACAO DE SALDO   *}
   {*********************JC*}


    Else If (Sender = edtLocFis) And blnControleContagem Then
    begin
      If (Not  ControleContagemBalancoEstoque.fVerficaLocFis(edtLocFis.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Localização Fisica não encontra no cadastro de Localizações Fisica!', ['&O k']);
        edtLocFis.Clear;
        frmBalancoEstoqueDigManualLista.strLocFisContador := '';
        edtCodite.Clear;
        lblItemEstrutura.Visible := False;
        pSetFocus(edtLocFis);
        Result := False;
      End;

      If Result And blnControleContagem Then
      begin
        If ControleContagemBalancoEstoque.fTemContagemEmAbertoParaOutroOperador(edtLocFis.Text, strCodDig) Then
        Begin
          fMensagem('ATENÇÃO!', 'Localização em contagem por outro operador!', ['&O k']);
          Result := False;
        End
        Else If ControleContagemBalancoEstoque.fTemContagemFinalizadaParaOperador(edtLocFis.Text, strCodDig) Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador já finalizou a contagem dessa localização!', ['&O k']);
          Result := False;
        End
        Else If ControleContagemBalancoEstoque.fAtingiuLimiteContagem Then
        Begin
          fMensagem('ATENÇÃO!', 'Quantidade Maxíma de contagens para essa localização já foi efetuada!', ['&O k']);
          Result := False;
        End
        Else If ControleContagemBalancoEstoque.IntContagem = ControleContagemBalancoEstoque.fRetQuantidadeContagemMaxima Then
        Begin
          If Not fVerificaAcessoSistema('LIBCONTFINAL', strCodDig) Then
          Begin
            fMensagem('ATENÇÃO!', 'Operador sem direito de acesso para efetivar a última Contagem!', ['&O k']);
            Result := False;
          End;
        End;

        If Not Result Then
        Begin
          edtLocFis.Clear;
          frmBalancoEstoqueDigManualLista.strLocFisContador := '';
          edtCodite.Clear;
          lblItemEstrutura.Visible := False;
          pSetFocus(edtLocFis);
        End;
      end;
      If Result Then
        frmBalancoEstoqueDigManualLista.strLocFisContador := edtLocFis.Text;
    End


    Else If (Sender = edtSldCon) Then
    Begin
      If fEmptyStr(edtSldCon.Text) Then
        edtSldCon.Text := '0,000'
      Else If fStrToFloat(edtSldCon.Text) < 0 Then
        edtSldCon.Text := '0,000';
    End

   {****************************}
   {* VALIDACAO DE SALDO G/ML  *}
   {*************************JC*}
    Else If (Sender = edtSldMl) Then
    Begin
      If fEmptyStr(edtSldMl.Text) Then
        edtSldMl.Text := '0,0000'
      Else If fStrToFloat(edtSldMl.Text) < 0 Then
        edtSldMl.Text := '0,0000';
    End;

  End;

  btnFinalizaContagem.Enabled := blnControleContagem And (not fEmptyStr(edtLocFis.Text)) And (not fEmptyStr(edtSenDig.Text));

end;

Function TfrmBalancoEstoqueDigManual.fSalvaContagemEstrutura: Boolean;
  Var
    blnImpLis: Boolean;
Begin
  Result := False;

  blnImpLis := False;
  objBalancoEstrutura.First;

  While Not objBalancoEstrutura.Eof Do
  Begin
    Result := fSalvaContagem(objBalancoEstrutura.FieldByName('CODITE').AsString,
                             objBalancoEstrutura.FieldByName('QTDITE').AsFloat,
                             0,
                             objCadLot.fRetOrdemItem,
                             True,
                             blnImpLis,
                             blnConAcu,
                             intConEst,
                             strCodDig,
                             '',
                             Self);

    If Not Result Then
      Break;

    frmBalancoEstoqueDigManualLista.pAtualiza(objBalancoEstrutura.FieldByName('CODITE').AsString, '', False {blnRelerBanco});

    objBalancoEstrutura.Next;
  End;

  frmBalancoEstoqueDigManualLista.pAbreConsulta;
End;

{**************************************************}
{* ALTERA QUANTIDADE CONTAGEM ITEGER->ITE_SALCON  *}
{***********************************************JC*}
Function TfrmBalancoEstoqueDigManual.fSalvaContagemManual(strCodIte: String;
  fltSalCon, fltSalMl: Double; intOrdCon: Integer; blnSavLog, blnImpLis: Boolean; strLocFis, strCodOpe: String): Boolean;
begin
  Result := fSalvaContagem(strCodIte, fltSalCon, fltSalMl, intOrdCon, blnSavLog, blnImpLis, blnConAcu,
                           intConEst, strCodDig, '', Self, '', strLocFis, strCodOpe);

  frmBalancoEstoqueDigManualLista.pAtualiza(edtCodIte.Text, '', True, blnControleContagem, strCodDig, edtLocFis.Text);
  frmBalancoEstoqueDigManualLista.strCodContador := strCodDig;
  frmBalancoEstoqueDigManualLista.strLocFisContador := edtLocFis.Text;

  if blnExiOpe then
    pSetFocus(edtCodIte)
  Else
    Self.SelectFirst;
end;

procedure TfrmBalancoEstoqueDigManual.btnConfirmaClick(Sender: TObject);
  Var blnImpLis: Boolean;
begin
  inherited;

  If blnExiOpe and (Not fEmptyStr(edtDesOpe.Text)) then
    strOperCfg := edtCodOpe.text
  Else
    strOperCfg := strLoginUsuarioLogado;

  blnImpLis := False;
  With qryConIte Do
  If btnConfirma.Enabled And
    ((FieldByName('ITE_ITEATI').AsString = 'S') Or fAtivarItem(edtCodIte.Text, blnImpLis)) Then
    fSalvaContagemManual(edtCodIte.Text, fStrToFloat(edtSldCon.Text), fStrToFloat(edtSldMl.Text),
                         objCadLot.fRetOrdemItem, True, blnImpLis, edtLocFis.Text, strOperCfg);

end;

{************************************}
{* LIMPA A TELA PARA NOVA CONSULTA  *}
{*********************************JC*}
procedure TfrmBalancoEstoqueDigManual.pDesabilitar;
begin
  edtCodIte.Clear;
  edtLinGru.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtDesUni.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;
  edtSldCon.Clear;
  edtSldCon.Text      := '0,000';
  edtSldMl.Text       := '0,0000';
  edtSalCon.Clear;
  edtSalGml.Clear;
  edtSalAtu.Clear;
  edtSalAMl.Clear;
  pnlSaldo.Enabled    := False;
  btnConfirma.Enabled := False;
  If edtSalRes.Visible Then
    edtSalRes.Clear;
  If edtSalResVenSep.Visible Then
    edtSalResVenSep.Clear;

  If blnControleContagem And (Not pnlDigitador.Enabled) And (Not fEmptyStr(edtLocFis.Text)) Then
    pSetFocus(edtCodite)
  Else
  Begin
    If blnExiOpe Then
    Begin
      If fEmptyStr(edtDesOpe.Text) Then
        pSetFocus(edtCodOpe)
      Else
      Begin
        If pnlLocFis.Visible And fEmptyStr(edtLocFis.Text) And (Not fEmptyStr(edtNomDig.Text)) Then
          pSetFocus(edtLocFis)
        Else
        Begin
          If Not fEmptyStr(edtNomDig.Text) Then
            pSetFocus(edtCodite)
          Else
            Self.SelectFirst;
        End;
      End;
    End
    Else
    Begin
      If pnlLocFis.Visible And fEmptyStr(edtLocFis.Text) And (Not fEmptyStr(edtNomDig.Text)) Then
        pSetFocus(edtLocFis)
      Else
      Begin
        If Not fEmptyStr(edtNomDig.Text) Then
          pSetFocus(edtCodite)
        Else
          Self.SelectFirst;
      End;
    End;
  End;

  lblItemEstrutura.Visible := False;
end;

{*****************************}
{* HABILITA PARA CONFIRMAR   *}
{**************************JC*}
procedure TfrmBalancoEstoqueDigManual.pHabilitar;
begin
  pnlSaldo.Enabled    := True;
  btnConfirma.Enabled := True;
end;

procedure TfrmBalancoEstoqueDigManual.btnFinalizaContagemClick(Sender: TObject);
begin
  inherited;
  If (btnFinalizaContagem.Visible) And (btnFinalizaContagem.Enabled) Then
  Begin
    If ControleContagemBalancoEstoque.fFinalizaContagem(edtLocFis.Text, strCodDig) Then
    Begin
      blnReiniciando := True;
      pnlDigitador.Enabled := True;
      edtLocFis.Clear;
      frmBalancoEstoqueDigManualLista.strLocFisContador := '';

      pDesabilitar;
      edtSenDig.Clear;
      edtNomDig.Clear;
      strCodDig := '';
      pSetFocus(edtSenDig);
      frmBalancoEstoqueDigManualLista.strCodContador := strCodDig;
      frmBalancoEstoqueDigManualLista.pAbreConsulta;
      blnReiniciando := false;
    End;
  End
end;

procedure TfrmBalancoEstoqueDigManual.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  pDesabilitar;
  pMostraLote(False);
end;

procedure TfrmBalancoEstoqueDigManual.FormShow(Sender: TObject);
  Var
    intNumAmz: Integer;
begin
  inherited;

  intConEst := fCfgSis('CONEST');

  If intConEst = 2 Then
  Begin
    Self.ClientWidth := 800;
  End;

  Self.SelectFirst;

  frmBalancoEstoqueDigManualLista.objCadLot := objCadLot;
  frmBalancoEstoqueDigManualLista.Dock(pnlItens, pnlItens.BoundsRect);
  frmBalancoEstoqueDigManualLista.Show;

  frmBalancoEstoqueDigManualLista.blnControleContagem := blnControleContagem;

  pMostraLote(False);

  If pnlDigitador.Enabled Then
    pSetFocus(edtSenDig)
  Else
    pSetFocus(edtCodIte);

  strCodAmz := '';

  If (fCfgSis('CTLEST') = '2') And TCadLot.fTemContagemArmazem(strCodAmz, intNumAmz) Then
    If intNumAmz > 1 Then
      Caption := Caption + ' - Armazéns ' + strCodAmz
    Else
      Caption := Caption + ' - Armazém ' + strCodAmz + '-' + fRetNomeArmazem(strCodAmz);
end;

procedure TfrmBalancoEstoqueDigManual.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ControleContagemBalancoEstoque);
  FreeAndNil(frmBalancoEstoqueDigManualLote);

end;

procedure TfrmBalancoEstoqueDigManual.pMostraLote(blnMostrar: Boolean);
Begin
  If blnMostrar Then
  Begin
    pnlSaldo.Visible := False;
    pnlBotoes.Visible := False;
    pnlSalLot.Visible := True;

    ClientHeight := pnlProduto.Height + intpnlSalLotHeight + pnlInfo.Height + pnlItens.Height;

    frmBalancoEstoqueDigManualLote.strCodIte := edtCodIte.Text;
    frmBalancoEstoqueDigManualLote.strCodLote := strAutoSelLote;
    frmBalancoEstoqueDigManualLote.blnUsarInativos := chkUsarInativos.Checked;
    frmBalancoEstoqueDigManualLote.shpRed.Visible := chkUsarInativos.Checked;
    frmBalancoEstoqueDigManualLote.lbllegLotInativo.Visible := chkUsarInativos.Checked;
    frmBalancoEstoqueDigManualLote.Dock(pnlSalLot,pnlSalLot.BoundsRect);
    frmBalancoEstoqueDigManualLote.Show;
    frmBalancoEstoqueDigManualLote.pAbreConsulta;
    frmBalancoEstoqueDigManualLote.pOnCancel := pCancelLote;

    pSetFocus(frmBalancoEstoqueDigManualLote.dbgConsulta);

    if not fEmptyStr(strAutoSelLote) then
      frmBalancoEstoqueDigManualLote.dbgConsulta.SelectedIndex := 2;

    Self.Top := (Screen.Height - self.Height) Div 2;
  End
  Else
  Begin
    pnlSaldo.Visible := True;
    pnlBotoes.Visible := True;
    pnlSalLot.Visible := False;

    ClientHeight := pnlProduto.Height + pnlSaldo.Height + pnlInfo.Height + pnlBotoes.Height + pnlItens.Height;

    If frmBalancoEstoqueDigManualLote.cdsConsulta.Active Then
    Begin
      frmBalancoEstoqueDigManualLote.cdsConsulta.CancelUpdates;
      frmBalancoEstoqueDigManualLote.cdsConsulta.Close;
    End;
  End;
End;

procedure TfrmBalancoEstoqueDigManual.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : If (Not frmBalancoEstoqueDigManualLista.pnlPesquisa.Visible) And
                   (Not frmBalancoEstoqueDigManualLote.pnlPesquisa.Visible) Then
                Begin
                  If pnlSalLot.Visible Then
                  Begin
                    pMostraLote(False);
                    pSetFocus(edtCodIte);
                    edtCodIte.Clear;
                    lblItemEstrutura.Visible := False;
                  End
                  Else
                    Close;
                End

               Else
               Begin
                 If frmBalancoEstoqueDigManualLista.Active Then
                   frmBalancoEstoqueDigManualLista.FormKeyDown(Sender,Key,Shift)
                 Else If frmBalancoEstoqueDigManualLote.Active Then
                    frmBalancoEstoqueDigManualLote.FormKeyDown(Sender,Key,Shift);
               End;
  End;

end;

procedure TfrmBalancoEstoqueDigManual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pFreeAndNil(frmBalancoEstoqueDigManualLista);
  
end;

function TfrmBalancoEstoqueDigManual.fEhEstrutura(AStrCodIte: String): Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('AUTOINCREM','GERMAT', ['GMT_CODITE'], [AStrCodIte]));
end;

end.
