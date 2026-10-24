unit Contabilidade.View.ConfigLALUR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, MemoFocus,
  untTypesSistema, DBMemoFocus;

type
  TfrmConfigLALUR = class(TfrmPaiContabilidade)
    dtsConfig: TDataSource;
    pgcDados: TPageControl;
    tbsPrejFiscais: TTabSheet;
    tbsContSocial: TTabSheet;
    tbsPrejFiscaisN: TTabSheet;
    tbsBaseCalcNeg: TTabSheet;
    tbsPagamentos: TTabSheet;
    dbeConPfo: TDBEditFocus;
    edtConPfo: TEditFocus;
    Label1: TLabel;
    dbeHcoPfo: TDBEditFocus;
    dbeHtrPfo: TDBEditFocus;
    Label2: TLabel;
    dbeHapPfo: TDBEditFocus;
    Label3: TLabel;
    edtCcaPfo: TEditFocus;
    dbeCcaPfo: TDBEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    dbeNatCsl: TDBEditFocus;
    edtNatCsl: TEditFocus;
    Label6: TLabel;
    dbeHstCsl: TDBEditFocus;
    Label7: TLabel;
    dbeConPno: TDBEditFocus;
    edtConPno: TEditFocus;
    Label8: TLabel;
    dbeHcoPno: TDBEditFocus;
    dbeHtrPno: TDBEditFocus;
    Label9: TLabel;
    dbeHapPno: TDBEditFocus;
    Label10: TLabel;
    edtCcaPno: TEditFocus;
    dbeCcaPno: TDBEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    dbeConCnc: TDBEditFocus;
    edtConCnc: TEditFocus;
    Label13: TLabel;
    dbeHcoCnc: TDBEditFocus;
    dbeHapCnc: TDBEditFocus;
    Label14: TLabel;
    edtCcaCnc: TEditFocus;
    dbeCcaCnc: TDBEditFocus;
    Label15: TLabel;
    Label16: TLabel;
    dbeConIrp: TDBEditFocus;
    edtConIrp: TEditFocus;
    Label17: TLabel;
    dbeConCsl: TDBEditFocus;
    edtConCsl: TEditFocus;
    btnGravar: TBitBtnLocked;
    memHcoPfo: TDBMemoFocus;
    memHtrPfo: TDBMemoFocus;
    memHapPfo: TDBMemoFocus;
    memHcoPno: TDBMemoFocus;
    memHtrPno: TDBMemoFocus;
    memHapPno: TDBMemoFocus;
    memHstCsl: TDBMemoFocus;
    memHcoCnc: TDBMemoFocus;
    memHapCnc: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeConPfoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeHcoPfoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbeCcaPfoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeConIrpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeConCncKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNatCslKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pCarregaCampos;
    procedure pFormataCampos;
    procedure pLimpaCampos; 
    procedure pCarregaPlanoContabil(strCodigo: String; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False);
    function fValidaPlanoContabil(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus): Boolean;
    procedure pCarregaNaturezaAjustes(strCodigo: String; edtDscricao: TEditFocus; ATipMov: string);
    function fValidaNaturezaAjustes(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; ATipMov: string): Boolean;
    function fValidaContaControladaParteB(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus): Boolean;
    procedure pCarregaContaControladaParteB(strCodigo: String;
      edtDscricao: TEditFocus);
    function fValidaHistoricoPadrao(edtCodigo: TDBEditFocus; memDscricao: TDBMemoFocus; const blnBuscaPorChave: boolean): Boolean;
    procedure pCarregaHistoricoPadrao(strCodigo: String; memDscricao: TDBMemoFocus);
    function fValidaInfoHistoricoPadrao:boolean ;
    function fValidaInfoHistoricoPadraoPrejFiscais(const ATab: TTabSheet):boolean ;
    function fValidaInfoHistoricoPadraoPrejFiscaisN(const ATab: TTabSheet):boolean ;
    function fValidaInfoHistoricoPadraoContSocial(const ATab: TTabSheet):boolean ;
    function fValidaInfoHistoricoPadraoBaseCalcNeg(const ATab: TTabSheet):boolean ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmConfigLALUR: TfrmConfigLALUR;

implementation

uses
  untFuncoesSimples, Contabilidade.Consultas, Contabilidade.Funcoes;

{$R *.dfm}

{ TfrmConfigLALUR }

procedure TfrmConfigLALUR.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  if Not fValidaInfoHistoricoPadrao then
  begin
    exit ;
  end;


  If fMensagem('', 'Confirma a gravação?', ['&Sim','&Não']) = 2 Then
    Exit;

  Try
    pLimpaCampos;

    qryTabela.Post;
    ModalResult := mrOk;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Gravar Registro');
    End;
  End;
end;

procedure TfrmConfigLALUR.dbeCcaPfoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqNaturezaDosAjustes(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons, 'C') Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLALUR.dbeConCncKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqContaControlada(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLALUR.dbeConIrpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryTabela.FieldByName(TDBEditFocus(Sender).DataField).EditMask := '';
    try
      If fPesqPlanoContabil(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons) Then
      Begin
        If fValidaCampos(TDBEditFocus(Sender), True) Then
          SelectNext(ActiveControl, True, True);
      End;
    finally
      qryTabela.FieldByName(TDBEditFocus(Sender).DataField).EditMask := fMskCon;
    end;
  End;
end;

procedure TfrmConfigLALUR.dbeConPfoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqContaControlada(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLALUR.dbeHcoPfoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqHistoricoPadrao(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLALUR.dbeNatCslKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqNaturezaDosAjustes(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons, 'A') Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLALUR.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult <> MrOk Then
    CanClose := fMensagem('', 'Deseja realmente cancelar?', ['&Sim','&Não']) = 1;
end;

procedure TfrmConfigLALUR.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriarQuery('SELECT * FROM CFLALU WHERE CFG_CODEMP = :CODEMP', Self);
  dtsConfig.DataSet := qryTabela;

  pFormataCampos;
end;

procedure TfrmConfigLALUR.FormShow(Sender: TObject);
begin
  inherited;
  qryTabela.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTabela.Open;

  If qryTabela.IsEmpty Then
  Begin
    qryTabela.Insert;
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFLALU', VS_strCodEmp);
    qryTabela.FieldByname('CFG_CODEMP').AsString := VS_strCodEmp;
  End
  Else
    qryTabela.Edit;

  pgcDados.ActivePage := tbsPrejFiscais;

  pCarregaCampos;
end;

function TfrmConfigLALUR.fValidaNaturezaAjustes(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; ATipMov: string): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaNaturezaAjustes(edtCodigo.Text, edtDscricao, ATipMov);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Natureza não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

function TfrmConfigLALUR.fValidaPlanoContabil(edtCodigo: TDBEditFocus;
  edtDscricao: TEditFocus): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaPlanoContabil(edtCodigo.Text, edtDscricao, True);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Conta Contábil não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

procedure TfrmConfigLALUR.pCarregaNaturezaAjustes(strCodigo: String; edtDscricao: TEditFocus; ATipMov: string);
begin
  If Not fEmptyStr(strCodigo) Then
    edtDscricao.Text := fCampoTabela('NAT_DESCRI', 'NATAJU', ['NAT_CODIGO','NAT_TIPMOV'], [strCodigo, ATipMov], False)
  Else
    edtDscricao.Clear;
end;

procedure TfrmConfigLALUR.pCarregaPlanoContabil(strCodigo: String; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False);
begin
  If Not fEmptyStr(strCodigo) Then
  begin
    if blnBuscaPorChave then
    begin
      edtDscricao.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [strCodigo], False);
    end
    else
    begin
      edtDscricao.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strCodigo], False);
    end;
  end
  Else
  begin
    edtDscricao.Clear;
  end;
end;

procedure TfrmConfigLALUR.pCarregaCampos;
begin
  pCarregaContaControladaParteB(dbeConPfo.Text, edtConPfo);
  pCarregaNaturezaAjustes(dbeNatCsl.Text, edtNatCsl, 'A');
  pCarregaContaControladaParteB(dbeConPno.Text, edtConPno);
  pCarregaContaControladaParteB(dbeConCnc.Text, edtConCnc);

  //pCarregaHistoricoPadrao(dbeHcoPfo.Text, memHcoPfo);
  //pCarregaHistoricoPadrao(dbeHtrPfo.Text, memHtrPfo);
  //pCarregaHistoricoPadrao(dbeHapPfo.Text, memHapPfo);
  //pCarregaHistoricoPadrao(dbeHstCsl.Text, memHstCsl);
  //pCarregaHistoricoPadrao(dbeHcoPno.Text, memHcoPno);
  //pCarregaHistoricoPadrao(dbeHtrPno.Text, memHtrPno);
  //pCarregaHistoricoPadrao(dbeHapPno.Text, memHapPno);
  //pCarregaHistoricoPadrao(dbeHcoCnc.Text, memHcoCnc);
  //pCarregaHistoricoPadrao(dbeHapCnc.Text, memHapCnc);

  pCarregaNaturezaAjustes(dbeCcaPfo.Text, edtCcaPfo, 'C');
  pCarregaNaturezaAjustes(dbeCcaPno.Text, edtCcaPno, 'C');
  pCarregaNaturezaAjustes(dbeCcaCnc.Text, edtCcaCnc, 'C');

  pCarregaPlanoContabil(dbeConIrp.Text, edtConIrp);
  pCarregaPlanoContabil(dbeConCsl.Text, edtConCsl);
end;

procedure TfrmConfigLALUR.pFormataCampos;
begin
  qryTabela.FieldByName('CFG_CONIRP').EditMask := fMskCon;
  qryTabela.FieldByName('CFG_CONCSL').EditMask := fMskCon;

  qryTabela.FieldByName('CFG_HCOPFO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HTRPFO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HAPPFO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HSTCSL').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HCOPNO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HTRPNO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HAPPNO').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HCOCNC').Alignment := taLeftJustify;
  qryTabela.FieldByName('CFG_HAPCNC').Alignment := taLeftJustify;
end;

procedure TfrmConfigLALUR.pLimpaCampos;
  Var
    intCont: Integer;
begin
  For intCont := 0 To qryTabela.FieldCount -1 Do
  Begin
    If qryTabela.Fields[intCont].AsString.Trim.IsEmpty Then
      qryTabela.Fields[intCont].Value := Null;
  End;
end;

function TfrmConfigLALUR.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    { Prej. Fiscais Operac. }
    If (Sender = dbeConPfo) Then
    Begin
      Result := fValidaContaControladaParteB(dbeConPfo, edtConPfo);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscais;
    End
    Else If (Sender = dbeHcoPfo) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHcoPfo, memHcoPfo, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscais;
    End
    Else If (Sender = dbeHtrPfo) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHtrPfo, memHtrPfo, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscais;
    End
    Else If (Sender = dbeHapPfo) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHapPfo, memHapPfo, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscais;
    End
    Else If (Sender = dbeCcaPfo) Then
    Begin
      Result := fValidaNaturezaAjustes(dbeCcaPfo, edtCcaPfo, 'C');
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscais;
    End

    { Cont. Social s/ Lucro }
    Else If (Sender = dbeNatCsl) Then
    Begin
      Result := fValidaNaturezaAjustes(dbeNatCsl, edtNatCsl, 'A');
      If Not Result Then
        pgcDados.ActivePage := tbsContSocial;
    End
    Else If (Sender = dbeHstCsl ) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHstCsl, memHstCsl, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsContSocial;
    End

    { Prej. Fiscais Não Operac. }
    Else If (Sender = dbeConPno) Then
    Begin
      Result := fValidaContaControladaParteB(dbeConPno, edtConPno);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscaisN;
    End
    Else If (Sender = dbeHcoPno) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHcoPno, memHcoPno, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscaisN;
    End
    Else If (Sender = dbeHtrPno) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHtrPno, memHtrPno, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscaisN;
    End
    Else If (Sender = dbeHapPno) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHapPno, memHapPno, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscaisN;
    End
    Else If (Sender = dbeCcaPno) Then
    Begin
      Result := fValidaNaturezaAjustes(dbeCcaPno, edtCcaPno, 'C');
      If Not Result Then
        pgcDados.ActivePage := tbsPrejFiscaisN;
    End

    { Base de Cálc. Negativa CSL }
    Else If (Sender = dbeConCnc) Then
    Begin
      Result := fValidaContaControladaParteB(dbeConCnc, edtConCnc);
      If Not Result Then
        pgcDados.ActivePage := tbsBaseCalcNeg;
    End
    Else If (Sender = dbeHcoCnc) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHcoCnc, memHcoCnc, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsBaseCalcNeg;
    End
    Else If (Sender = dbeHapCnc) Then
    Begin
      Result := fValidaHistoricoPadrao(dbeHapCnc, memHapCnc, blnBuscaPorChave);
      If Not Result Then
        pgcDados.ActivePage := tbsBaseCalcNeg;
    End
    Else If (Sender = dbeCcaCnc) Then
    Begin
      Result := fValidaNaturezaAjustes(dbeCcaCnc, edtCcaCnc, 'C');
      If Not Result Then
        pgcDados.ActivePage := tbsBaseCalcNeg;
    End

    { Pagamentos }
    Else If (Sender = dbeConIrp) Then
    Begin
      Result := fValidaPlanoContabil(dbeConIrp, edtConIrp);
      If Not Result Then
        pgcDados.ActivePage := tbsPagamentos;
    End
    Else If (Sender = dbeConCsl) Then
    Begin
      Result := fValidaPlanoContabil(dbeConCsl, edtConCsl);
      If Not Result Then
        pgcDados.ActivePage := tbsPagamentos;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmConfigLALUR.fValidaContaControladaParteB(edtCodigo: TDBEditFocus;
  edtDscricao: TEditFocus): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaContaControladaParteB(edtCodigo.Text, edtDscricao);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Conta Controlada Parte B não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

function TfrmConfigLALUR.fValidaInfoHistoricoPadrao: boolean;
begin
  /// tbsPrejFiscais
  result := fValidaInfoHistoricoPadraoPrejFiscais(tbsPrejFiscais) ;
  if not Result then
  begin
    exit ;
  end;
  /// tbsPrejFiscaisN
  result := fValidaInfoHistoricoPadraoPrejFiscaisN(tbsPrejFiscaisN) ;
  if not Result then
  begin
    exit ;
  end;
  ///// tbsContSocial
  result := fValidaInfoHistoricoPadraoContSocial(tbsContSocial) ;
  if not Result then
  begin
    exit ;
  end;
  ////tbsBaseCalcNeg
  result := fValidaInfoHistoricoPadraoBaseCalcNeg(tbsBaseCalcNeg) ;
  if not Result then
  begin
    exit ;
  end;
end;

function TfrmConfigLALUR.fValidaInfoHistoricoPadraoBaseCalcNeg(
  const ATab: TTabSheet): boolean;
var
  strHistorico: string ;
begin
  Result := False ;
  strHistorico := dbeHcoCnc.Field.AsString.Trim() + memHcoCnc.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHcoCnc);
    exit ;
  end;

  strHistorico := dbeHapCnc.Field.AsString.Trim() + memHapCnc.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHapCnc);
    exit ;
  end;
  Result := True ;
end;

function TfrmConfigLALUR.fValidaInfoHistoricoPadraoContSocial(
  const ATab: TTabSheet): boolean;
var
  strHistorico: string ;
begin
  Result := False ;
  strHistorico := dbeHstCsl.Field.AsString.Trim() + memHstCsl.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHstCsl);
    exit ;
  end;
  Result := True ;
end;

function TfrmConfigLALUR.fValidaInfoHistoricoPadraoPrejFiscais(
  const ATab: TTabSheet): boolean;
var
  strHistorico: string ;
begin
  Result := False ;
  strHistorico := dbeHcoPfo.Field.AsString.Trim() + memHcoPfo.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHcoPfo);
    exit ;
  end;

  strHistorico := dbeHtrPfo.Field.AsString.Trim() + memHtrPfo.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHtrPfo);
    exit ;
  end;

  strHistorico := dbeHapPfo.Field.AsString.Trim() + memHapPfo.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHapPfo);
    exit ;
  end;
  Result := True ;
end;

function TfrmConfigLALUR.fValidaInfoHistoricoPadraoPrejFiscaisN(
  const ATab: TTabSheet): boolean;
var
  strHistorico: string ;
begin
  Result := False ;
  strHistorico := dbeHcoPno.Field.AsString.Trim() + memHcoPno.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHcoPno);
    exit ;
  end;

  strHistorico := dbeHtrPno.Field.AsString.Trim() + memHtrPno.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHtrPno);
    exit ;
  end;

  strHistorico := dbeHapPno.Field.AsString.Trim() + memHapPno.Field.AsString.Trim() ;
  if fEmptyStr(strHistorico) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico não informado!', ['&Ok']);
    pgcDados.ActivePage := ATab;
    pSetFocus(dbeHapPno);
    exit ;
  end;
  Result := True ;
end;

procedure TfrmConfigLALUR.pCarregaContaControladaParteB(strCodigo: String; edtDscricao: TEditFocus);
begin
  If Not fEmptyStr(strCodigo) Then
  begin
    edtDscricao.Text := fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON'], [strCodigo], False);
  end
  Else
  begin
    edtDscricao.Clear;
  end;
end;

function TfrmConfigLALUR.fValidaHistoricoPadrao(edtCodigo: TDBEditFocus; memDscricao: TDBMemoFocus; const blnBuscaPorChave: boolean): Boolean;
begin
  Result := True;

  if not blnBuscaPorChave then
  begin
    exit ;
  end;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaHistoricoPadrao(edtCodigo.Text, memDscricao);

    If fEmptyStr(memDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Histórico Padrão não encontrado!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    memDscricao.Field.Clear;
end;

procedure TfrmConfigLALUR.pCarregaHistoricoPadrao(strCodigo: String; memDscricao: TDBMemoFocus);
begin
  If Not fEmptyStr(strCodigo) Then
    memDscricao.Field.AsString := fRetDescHistoricoPadrao(strCodigo, VS_strCodEmp)
  Else
    memDscricao.Field.Clear;
end;

end.
