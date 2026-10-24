unit Contabilidade.View.ContasControladas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiCadContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, ComboBoxFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, EditFocus, QColorLabel, MemDS, DBAccess,
  Uni, Contabilidade.Interfaces;

type
  TfrmCadContasControladas = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeCodCon: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label3: TLabel;
    cbxTipTab: TComboBoxFocus;
    dtsCtaCon: TDataSource;
    gbLalur: TGroupBox;
    Label4: TLabel;
    dbeTbdElu: TDBEditFocus;
    edtTbdElu: TEditFocus;
    Label5: TLabel;
    dbeTbdBlu: TDBEditFocus;
    edtTbdBlu: TEditFocus;
    chkGerLal: TDBCheckBox;
    gbLacs: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    dbeTbdEla: TDBEditFocus;
    edtTbdEla: TEditFocus;
    dbeTbdBla: TDBEditFocus;
    edtTbdBla: TEditFocus;
    chkGerLac: TDBCheckBox;
    Label15: TLabel;
    edtDesEmp: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeTbdEluKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure chkGerLalClick(Sender: TObject);
    procedure chkGerLacClick(Sender: TObject);
    procedure dbeTbdElaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTbdBluKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTbdBlaKeyPress(Sender: TObject; var Key: Char);
    procedure cbxTipTabChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FllTipo: TLacsLalur ;
    FstrContaControlada: string ;
    procedure pCarregaCampos;
    procedure pLimpaCampos;
    procedure pSelecionaTipoTabela;
    function fValidaDemonstrativoECF(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; chkSelecionado: TDBCheckBox; const ALalurLacs: String; var ABloco, ARegistro: string): Boolean;
    function fValidaPadraoRFBParteB(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; chkSelecionado: TDBCheckBox; const ALalurLacs: String): Boolean;
    procedure pCarregaTipoTabela ;
    procedure pLimpaObjTipoTabela ;
    procedure pAtualizaLalurLacsCampos;
    procedure pAbreIncluindoLalurLacs;
    function fRetDescEmpresa(const AstrCodigo: String): String;
  public
    { Public declarations }
    property CodigoContaControlada: string read FstrContaControlada ;
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, Contabilidade.Consultas,
  Contabilidade.Funcoes, Contabilidade.Classes.ApuracaoLucroRealLalurLacs,
  untConsultas;

type
  TCodigo = class
    valor: integer ;
  end;

{$R *.dfm}

{ TfrmCadContasControladas }

procedure TfrmCadContasControladas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCon, dbeCodEmp, False);
end;

procedure TfrmCadContasControladas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaCampos;
end;

procedure TfrmCadContasControladas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaCampos;
end;

procedure TfrmCadContasControladas.btnGravarClick(Sender: TObject);
begin
  pLimpaCampos;
  qryTabela.FieldByName('CTA_TIPTAB').AsInteger := TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor;

  inherited;

  pSelecionaTipoTabela;
end;

procedure TfrmCadContasControladas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCon, dbeCodCon, False);

  pLimparCampos;
  qryTabela.FieldByName('CTA_TIPTAB').AsString := '1';
  qryTabela.FieldByName('CTA_GRLACS').AsString := 'N';
  qryTabela.FieldByName('CTA_GRLALU').AsString := 'N';
  pSelecionaTipoTabela;

  if FllTipo = llLacs then
  begin
    chkGerLac.Field.AsString := 'S';
    chkGerLal.Enabled := False ;
    chkGerLac.Enabled := False ;
    dbeTbdBla.Enabled := False ;
    dbeTbdBlu.Enabled := False ;
    dbeTbdBla.Field.AsString := COD_BASE_CALCULO_NEGATIVA_CSLL ;
    fValidaCampos(dbeTbdBla) ;
  end
  else if FllTipo = llLalur then
  begin
    chkGerLal.Field.AsString := 'S';
    chkGerlac.Enabled := False ;
    chkGerLal.Enabled := False ;
    dbeTbdBla.Enabled := False ;
    dbeTbdBlu.Enabled := False ;
    dbeTbdBlu.Field.AsString := COD_PREJUIZO_FISCAL_OPERACIONAL ;
    fValidaCampos(dbeTbdBlu) ;
  end;
  pSetFocus(dbeCodEmp) ;
end;

procedure TfrmCadContasControladas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCons: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqContaControlada(Self, Nil, Nil, qryTabela, chrKey, arrCons) Then
  Begin
    pCarregaCampos;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadContasControladas.cbxTipTabChange(Sender: TObject);
begin
  inherited;
  dbeTbdEla.Field.Clear ;
  edtTbdEla.Clear ;
  dbeTbdBla.Field.Clear ;
  edtTbdBla.Clear ;
  dtsCtaCon.DataSet.FieldByName('CTA_BLDELA').Clear ;
  dtsCtaCon.DataSet.FieldByName('CTA_RGDELA').Clear ;
  dbeTbdElu.Field.Clear ;
  edtTbdElu.Clear ;
  dbeTbdBlu.Field.Clear ;
  edtTbdBlu.Clear ;
  dtsCtaCon.DataSet.FieldByName('CTA_BLDELU').Clear ;
  dtsCtaCon.DataSet.FieldByName('CTA_RGDELU').Clear ;
end;

procedure TfrmCadContasControladas.chkGerLacClick(Sender: TObject);
begin
  inherited;
  pAtualizaLalurLacsCampos ;
  if not chkGerLac.Checked then
  begin
    if dtsCtaCon.DataSet.State in [dsEdit, dsInsert] then
    begin
      dbeTbdEla.Field.Clear ;
      edtTbdEla.Clear ;
      dtsCtaCon.DataSet.FieldByName('CTA_BLDELA').Clear ;
      dtsCtaCon.DataSet.FieldByName('CTA_RGDELA').Clear ;

      dbeTbdBla.Field.Clear ;
      edtTbdBla.Clear ;
    end;
  end;
end;

procedure TfrmCadContasControladas.chkGerLalClick(Sender: TObject);
begin
  inherited;
  pAtualizaLalurLacsCampos ;
  if not chkGerLal.Checked then
  begin
    if dtsCtaCon.DataSet.State in [dsEdit, dsInsert] then
    begin
      dbeTbdElu.Field.Clear ;
      edtTbdElu.Clear ;
      dtsCtaCon.DataSet.FieldByName('CTA_BLDELU').Clear ;
      dtsCtaCon.DataSet.FieldByName('CTA_RGDELU').Clear ;

      dbeTbdBlu.Field.Clear ;
      edtTbdBlu.Clear ;
    end;
  end;
end;

procedure TfrmCadContasControladas.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmp, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadContasControladas.dbeTbdBlaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LTributo: string;
begin
  if fEntraCons(Key) then
  begin
    LTributo := quotedstr('C') + ',' + quotedstr('A') ;
    If fPesqECFPadraoRFBParteB(Self,
                               TDBEditFocus(Sender),
                               edtTbdBla,
                               Nil,
                               Key,
                               arrCons,
                               False,
                               LTributo) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCadContasControladas.dbeTbdBluKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LTributo: string;
begin
  if fEntraCons(Key) then
  begin
    LTributo := quotedstr('I') + ',' + quotedstr('A') ;
    If fPesqECFPadraoRFBParteB(Self,
                               TDBEditFocus(Sender),
                               edtTbdBlu,
                               Nil,
                               Key,
                               arrCons,
                               False,
                               LTributo) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCadContasControladas.dbeTbdElaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LBloco, LRegistro, LTipo, LOrientacao: string;
begin
  if fEntraCons(Key) then
  begin
    pRetornaFiltroAdicionalDemonstrativoECF(
       'C',
       intTostr(TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor),
       cLACS,
       LBloco,
       LRegistro,
       LTipo,
       LOrientacao) ;
    If fPesqECFDemonstrativo(Self,
                             TDBEditFocus(Sender),
                             edtTbdEla,
                             Nil,
                             Key,
                             arrCons,
                             False,
                             LBloco,
                             LRegistro,
                             LTipo,
                             LOrientacao) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCadContasControladas.dbeTbdEluKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LBloco, LRegistro, LTipo, LOrientacao: string;
begin
  if fEntraCons(Key) then
  begin
    pRetornaFiltroAdicionalDemonstrativoECF(
       'C',
       intTostr(TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor),
       cLalur,
       LBloco,
       LRegistro,
       LTipo,
       LOrientacao) ;
    If fPesqECFDemonstrativo(Self,
                             TDBEditFocus(Sender),
                             edtTbdElu,
                             Nil,
                             Key,
                             arrCons,
                             False,
                             LBloco,
                             LRegistro,
                             LTipo,
                             LOrientacao) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCadContasControladas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if FllTipo <> llNada then
  begin
    if btnGravar.Enabled then
    begin
      fMensagem('ATENÇÃO!', 'Gravar ou Cancelar a Inclusão do Registro!', ['&Ok']);
      CanClose := False ;
      exit ;
    end;
    FstrContaControlada := dbeCodCon.Field.AsString ;
  end;
end;

procedure TfrmCadContasControladas.FormCreate(Sender: TObject);
begin
  inherited;
  inherited;
  strNomeTabela := 'CTACON';
  strNomeCampo  := 'CTA_CODCON';

  qryTabela         := fCriarQuery('SELECT * FROM CTACON', Self);
  dtsCtaCon.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCon;

  pCarregaTipoTabela ;

  FllTipo :=  llNada ;
  FstrContaControlada := '' ;

end;

procedure TfrmCadContasControladas.FormDestroy(Sender: TObject);
begin
  inherited;
  pLimpaObjTipoTabela ;
end;

procedure TfrmCadContasControladas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCampos;
  pAbreIncluindoLalurLacs ;
end;

function TfrmCadContasControladas.fRetDescEmpresa(
  const AstrCodigo: String): String;
begin
  Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [AstrCodigo], False);
end;

function TfrmCadContasControladas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LBloco, LRegistro: string ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Conta deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = cbxTipTab) Then
    Begin
      If (cbxTipTab.ItemIndex = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo da Tabela Dinâmica deve ser preenchido', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeTbdElu) Then
    Begin
      Result := fValidaDemonstrativoECF(dbeTbdElu, edtTbdElu, chkGerLal, cLALUR, LBloco, LRegistro);
      dtsCtaCon.DataSet.FieldByName('CTA_BLDELU').AsString := LBloco ;
      dtsCtaCon.DataSet.FieldByName('CTA_RGDELU').AsString := LRegistro ;
    End
    Else If (Sender = dbeCodEmp) Then
    Begin
      if not fEmptyStr(dbeCodEmp.Text) then
      Begin
        edtDesEmp.Text := fRetDescEmpresa(dbeCodEmp.Text);
        if fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtDesEmp.Clear;
        dbeCodEmp.DataSource.DataSet.FieldByName('CTA_CODEMP').Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = dbeTbdBlu) Then
    Begin
      Result := fValidaPadraoRFBParteB(dbeTbdBlu, edtTbdBlu, chkGerLal, cLALUR);
    End
    Else If (Sender = dbeTbdEla) Then
    Begin
      Result := fValidaDemonstrativoECF(dbeTbdEla, edtTbdEla, chkGerLac, cLACS, LBloco, LRegistro);
      dtsCtaCon.DataSet.FieldByName('CTA_BLDELA').AsString := LBloco ;
      dtsCtaCon.DataSet.FieldByName('CTA_RGDELA').AsString := LRegistro ;
    End
    Else If (Sender = dbeTbdBla) Then
    Begin
      Result := fValidaPadraoRFBParteB(dbeTbdBla, edtTbdBla, chkGerLac, cLACS);
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadContasControladas.fValidaDemonstrativoECF(
  edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; chkSelecionado: TDBCheckBox; const ALalurLacs: String; var ABloco, ARegistro: string): Boolean;
begin
  Result := True;

  If chkSelecionado.Checked Then
  Begin
    edtDscricao.Text := fRetDescDemonstrativoECF(edtCodigo.Text, ALalurLacs, 'C', IntToStr(TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor), ABloco, ARegistro) ;

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Registro não encontrado!', ['&Ok']);
      Result := False;
      ABloco := '' ;
      ARegistro := '' ;
    End;
  End
  Else
  begin
    edtDscricao.Clear;
    ABloco := '' ;
    ARegistro := '' ;
  end;
end;

function TfrmCadContasControladas.fValidaPadraoRFBParteB(
  edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; chkSelecionado: TDBCheckBox; const ALalurLacs: String): Boolean;
var
  LTributo : string ;
begin
  Result := True;

  If chkSelecionado.Checked Then
  Begin
    if ALalurLacs = cLALUR then
    begin
      LTributo := quotedstr('I') + ',' + quotedstr('A') ;
    end
    else /// LACS
    begin
      LTributo := quotedstr('C') + ',' + quotedstr('A') ;
    end;

    edtDscricao.Text := fRetDescPadraoRFBParteB(edtCodigo.Text, LTributo) ;

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tabela Padrão RFB Parte B não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

procedure TfrmCadContasControladas.pCarregaCampos;
var
  LTributo : string ;
  LRegistro, LBloco: string;
begin
   pSelecionaTipoTabela;

   LTributo := quotedstr('I') + ',' + quotedstr('A') ;
   edtTbdBlu.Text := fRetDescPadraoRFBParteB(dbeTbdBlu.Text, LTributo) ;
   LTributo := quotedstr('C') + ',' + quotedstr('A') ;
   edtTbdBla.Text := fRetDescPadraoRFBParteB(dbeTbdBla.Text, LTributo) ;
   edtDesEmp.Text := fRetDescEmpresa(dbeCodEmp.Text) ;

   if cbxTipTab.ItemIndex <> -1 then
   begin
     edtTbdElu.Text := fRetDescDemonstrativoECF(dbeTbdElu.Text, cLALUR, 'C', IntToStr(TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor), LBloco, LRegistro) ;
     edtTbdEla.Text := fRetDescDemonstrativoECF(dbeTbdEla.Text, cLACS, 'C', IntToStr(TCodigo(cbxTipTab.Items.Objects[cbxTipTab.ItemIndex]).valor), LBloco, LRegistro) ;
   end
   else
   begin
     edtTbdElu.Text := '' ;
     edtTbdEla.Text := '' ;
   end;

  pAtualizaLalurLacsCampos;
end;

procedure TfrmCadContasControladas.pCarregaTipoTabela;
var
  qryTipo: TUniQuery ;
  objValor: TCodigo ;
begin

  cbxTipTab.Items.Clear ;

  qryTipo := fCriaQuery() ;
  try
    qryTipo.Close ;
    qryTipo.SQL.Clear ;
    qryTipo.SQL.Add('SELECT ECF_CODIGO, ECF_DESCRI FROM TABECF') ;
    qryTipo.Open ;
    qryTipo.First ;
    while not qryTipo.Eof do
    begin
      objValor := TCodigo.Create ;
      objValor.valor := qryTipo.FieldByName('ECF_CODIGO').AsInteger ;
      cbxTipTab.Items.AddObject(qryTipo.FieldByName('ECF_DESCRI').AsString, objValor) ;
      qryTipo.Next ;
    end;
  finally
    FreeAndNil(qryTipo) ;
  end;
end;

procedure TfrmCadContasControladas.pSelecionaTipoTabela;
var
  intCnt: integer ;
begin
  cbxTipTab.OnChange := nil ;
  try
    cbxTipTab.ItemIndex := 0 ;
    for intCnt := 0 to cbxTipTab.Items.Count-1 do
    begin
      if TCodigo(cbxTipTab.Items.Objects[intCnt]).valor = qryTabela.FieldByName('CTA_TIPTAB').AsInteger then
      begin
        cbxTipTab.ItemIndex := intCnt ;
        break;
      end;
    end;
  finally
    cbxTipTab.OnChange := cbxTipTabChange ;
  end;
end;

procedure TfrmCadContasControladas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CTA_CODCON');
  stlCampos.Add('CTA_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CTA_DESCRI');
  stlCamInd.Add('CTA_CODCON');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmCadContasControladas.pLimpaCampos;
  Var
    intCont: Integer;
begin
  For intCont := 0 To qryTabela.FieldCount -1 Do
  Begin
    If qryTabela.Fields[intCont].AsString.Trim.IsEmpty Then
      qryTabela.Fields[intCont].Value := Null;
  End;
end;

procedure TfrmCadContasControladas.pLimpaObjTipoTabela;
Var
  intCont: Integer;
begin
  for intCont := 0 to cbxTipTab.Items.Count-1 do
  begin
    TCodigo(cbxTipTab.Items.Objects[intCont]).Free ;
  end;
end;

procedure TfrmCadContasControladas.pAbreIncluindoLalurLacs;
begin
  if FllTipo <>  llNada then
  begin
    btnIncluir.Click ;
    btnIncluir.Visible := False ;
    btnAlterar.Visible := False ;
    btnExcluir.Visible := False ;
  end ;
end;

procedure TfrmCadContasControladas.pAtualizaLalurLacsCampos;
begin
  dbeTbdElu.Enabled := chkGerLal.Checked ;
  dbeTbdBlu.Enabled := chkGerLal.Checked ;

  dbeTbdEla.Enabled := chkGerLac.Checked ;
  dbeTbdBla.Enabled := chkGerLac.Checked ;
end;

end.
