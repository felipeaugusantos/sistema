unit untCadPortadores;

interface

uses
  Classes, Controls, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, Menus, AppEvnts, untCadPor, DB, untPaiCad, EditFocus, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, QColorLabel,
  untfuncoesSimples, ComboBoxFocus, untTypesSistema, dxScreenTip, cxClasses,
  dxCustomHint, cxHint, Vcl.CheckLst, Winapi.Windows, System.StrUtils,
  Vcl.Graphics,untLogPor, Datasnap.DBClient, UniClientDataSet,

  untFuncoes, untFuncaoPortadores,untCfgRepositorio;

type
  TfrmCadPortadores = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodPor: TDBEditFocus;
    dbeDtaIni: TDBEditFocus;
    Label2: TLabel;
    dbeNomPor: TDBEditFocus;
    Label4: TLabel;
    dbeEntAna: TDBCheckBox;
    dbeEntFlu: TDBCheckBox;
    dbeEntPco: TDBCheckBox;
    dbeTransf: TDBCheckBox;
    Label5: TLabel;
    dbeDCrRec: TDBEditFocus;
    lblDesPlaCon: TLabel;
    dbeConCon: TDBEditFocus;
    dtsCadPor: TDataSource;
    dbeDepChe: TDBCheckBox;
    Label6: TLabel;
    dbeSigCon: TDBEditFocus;
    dbePerBai: TDBCheckBox;
    dbeMovBan: TDBCheckBox;
    Label7: TLabel;
    dbeCodBco: TDBEditFocus;
    edtNomBan: TEditFocus;
    dbeEntBod: TDBCheckBox;
    dbeBaiRcx: TDBCheckBox;
    btnChqEmi: TBitBtnLocked;
    chkBolFat: TDBCheckBox;
    btnAceOpe: TBitBtnLocked;
    DBCheckBox1: TDBCheckBox;
    dbeSalPor: TDBCheckBox;
    lblCarteira: TLabel;
    cbxCarteira: TComboBoxFocus;
    chkBaiUtl: TDBCheckBox;
    lblCompDescri: TLabel;
    HintControler: TcxHintStyleController;
    chkExiPor: TDBCheckBox;
    edtCCaVinc: TEditFocus;
    lblCCaVinc: TLabel;
    btnVincCCa: TBitBtnLocked;
    chkImpBol: TDBCheckBox;
    chkExpAut: TDBCheckBox;
    dbePlaNco: TDBEditFocus;
    edtDesPlaNco: TEditFocus;
    btnPlaNco: TBitBtnLocked;
    tbsEmpresas: TTabSheet;
    clbEmpCnd: TCheckListBox;
    pnlSelEmp: TPanel;
    lblLegenda: TLabel;
    grbModalidades: TGroupBox;
    dbeModDin: TDBCheckBox;
    dbeModChv: TDBCheckBox;
    dbeModChp: TDBCheckBox;
    dbeModCar: TDBCheckBox;
    dbeModOrd: TDBCheckBox;
    dbeModFin: TDBCheckBox;
    lblModalidades: TLabel;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    chkCONPOR: TDBCheckBox;
    dbeTitPDD: TDBCheckBox;
    lblCompDescriEntPco: TLabel;
    dbeBAICTF: TDBCheckBox;
    shpAltDtaIni: TShape;
    chkConOfx: TDBCheckBox;
    chkPerAut: TDBCheckBox;
    dbchkEstCtr: TDBCheckBox;
    lblFornecedorFiscal: TLabel;
    dbeCodigoFornecedorFiscal: TDBEditFocus;
    edtNomeFornecedorFiscal: TEditFocus;
    dbChkPerCreDeb: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodBcoChamaCadastro(Key: Word): string;
    procedure dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnChqEmiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAceOpeClick(Sender: TObject);
    procedure dbeCodBcoExit(Sender: TObject);
    procedure dbeCodBcoEnter(Sender: TObject);
    procedure chkBaiUtlEnter(Sender: TObject);
    procedure chkBaiUtlExit(Sender: TObject);
    procedure dtsCadPorStateChange(Sender: TObject);
    procedure btnVincCCaClick(Sender: TObject);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblModalidadesClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure chkConOfxClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodigoFornecedorFiscalKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objCadPor: TCadPor;
    qryCarPor: TUniQuery;
    arrBancos: TArrBancos;
    arrBanCar: TStringArray;
    blnUtiCon : Boolean;
    FcdsNCO : TUniClientDataset;

    procedure pAfterOpen(DataSet: TDataSet);
    function fGetChaveCarteiraBanco(intIndex: Integer): String;

    procedure pCarregarCarteirasBanco;
    procedure pSetaCarteiraBanco(strCarteira: String);

    procedure pCarregaCarteiraBancoPortador;
    procedure pSalvaCarteiraBancoPortador;

    procedure pCarregaBanco;
    procedure pGravaOperadoresPortador;
    procedure pShowHint(chkControl: TDBCheckBox; strTitulo: String);
    procedure pHideHint;
    procedure pCarregaCCa;
    function fCCaVinculada(strAutCCA: String): Boolean;
    function fMovimentouExtratoEletronico: Boolean;
    function fMovimentouPix: Boolean;
    function fExisteLancamentoPendente: Boolean;
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
    procedure pCarregaEmpresas;
    procedure pMarcarDesmarcarEmpresas(blnMarcar: Boolean);
    procedure pAbrirPoup;
    procedure pMarcarModalidades(blnMarcar: Boolean);
    procedure pInverterModalidades;
    function fGetEmpSelecao: String;
    function PortadorSemLogDeInclusao: Boolean;

    procedure CarregaFornecedorFiscal;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fExecutaAntesDoDelete : Boolean; override;
    function fProximoCodigo: String; override;
    function fPortadorCadastrado(ACodigoPortador: String): Boolean;
  public
    { Public declarations }
    strCodPorIniciarCadastro: String;
  end;

implementation

uses SysUtils, Variants, Forms, untPai, untConsultas, untFuncIns,
     untCadPorChqEmi, untOperadoresPortador, Contabilidade.Consultas,
     Contabilidade.Funcoes;

{$R *.dfm}

procedure TfrmCadPortadores.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);

  btnAceOpe.Visible := fCfgSis('DACPOR', varBoolean);
  btnAceOpe.Enabled := (btnAceOpe.Visible) And (fVerificaAcessoSistema('POROPE'));

  If (Not fCfgSis('DACPOR', varBoolean)) And (Not blnUtiCon) Then
  Begin
  //pnlBotoes.Height := pnlBotoes.Height - btnAceOpe.Height;
  //btnSair.Top := btnIncluir.Top;
  End;

  lblCompDescri.Enabled  := False;
  lblModalidades.Enabled := False;
  lblCompDescriEntPco.Enabled  := False;
end;

procedure TfrmCadPortadores.FormCreate(Sender: TObject);
begin
  objCadPor := TCadPor.Create(Self);
  FcdsNCO := fCriaEstruturaCdsNCO(Nil);
  inherited;
  strNomeTabela       := 'CADPOR';
  strNomeCampo        := 'POR_CODPOR';
  qryTabela           := objCadPor.qryTabela;
  qryTabela.AfterOpen := pAfterOpen;
  qryCarPor           := fCriaQuery(Self);
  dtsCadPor.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPor;
  blnUtiCon := fCfgSis('UTICON', varBoolean);
end;

procedure TfrmCadPortadores.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsNCO) then
    FreeAndNil(FcdsNCO) ;
end;

procedure TfrmCadPortadores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (pgcDados.ActivePage = tbsEmpresas) And pnlSelEmp.Visible Then
  Begin
    Case Key Of
      VK_F8: pMarcarDesmarcarEmpresas(True);
      VK_F9: pMarcarDesmarcarEmpresas(False);
    End;
  End
  Else inherited;
end;

function TfrmCadPortadores.fPortadorCadastrado(
  ACodigoPortador: String): Boolean;
Var
  LSQL   : String;
  LQryPortador: TUniQuery;
begin
  LQryPortador := fCriaQuery(Self);
  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  COUNT(*) AS QTD ';
    LSQL := LSQL + 'FROM ';
    LSQL := LSQL + '  CADPOR ';
    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  POR_CODPOR = :CODPOR ';

    LQryPortador.Close;
    LQryPortador.SQL.Clear;
    LQryPortador.SQL.Add(LSQL);
    LQryPortador.ParamByName('CODPOR').AsString := ACodigoPortador;
    LQryPortador.Open;

    Result := (LQryPortador.FieldByName('QTD').AsInteger > 0);
  Finally
    FreeAndNil(LQryPortador);
  End;
end;

function TfrmCadPortadores.fProximoCodigo: String;
var
  LCodProximoCodigo: String;
begin
  LCodProximoCodigo := fRetornaProCod(strNomeTabela);
  If (fPortadorCadastrado(LCodProximoCodigo)) Then
    Raise Exception.Create('Esse código de portador (' + LCodProximoCodigo + ') já está cadastrado!' + #13#10 +
                           'Verifique o cadastro de próximos códigos.');

  Result := inherited fProximoCodigo;
end;

function TfrmCadPortadores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      {*****************************************}
      {* VALIDA O CÓDIGO DO PORTADOR           *}
      {**************************************MV*}
      If (Sender = dbeCodPor) Then
      Begin
        If (fEmptyStr(dbeCodPor.Text)) And (dbeCodPor.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Portador deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        begin
          if fEmptyStr(dbeCodPor.Text) and blnUsaProCodigo then
            dbeCodPor.Text := fProximoCodigo;

          if dbeCodPor.Enabled then
          begin
            If (fPortadorCadastrado(dbeCodPor.Text)) Then
            Begin
              fMensagem('', 'Esse código de portador (' + dbeCodPor.Text + ') já está cadastrado!' + #13#10 +
                                     'Verifique o cadastro de próximos códigos.', ['&Ok']);
              Result := False;
            End;
          end;
        end;

        if (Length(dbeCodPor.Text) < 5) and (qryTabela.State = dsInsert) then
        begin
            dbeCodPor.Text := fStrZero(dbeCodPor.Text, 5);
        end;

        If dbeCodPor.Enabled Then
          objCadPor.strCodPor := dbeCodPor.Text;

        If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
            dbeDtaIni.Field.AsDateTime := VS_Date;
          End
          Else
          Begin
            dbeCodPor.Enabled := False;
            If dbeNomPor.Enabled Then
            Begin
              pgcDados.ActivePage := tbsGeral;
              pSetFocus(dbeNomPor);
              blnMudarFoco := False;
            End;
          End;

          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Not (qryTabela.State In [dsInsert]) Then
            Begin
              If Not fEmptyStr(dbeCodPor.Text) Then
              Begin
                If Pos(dbeCodPor.Text, strPortadoresOperador) <= 0 Then
                Begin
                  fMensagem('', 'Usuário sem permissão de acesso ao portador!', ['&Ok']);
                  btnAlterar.Enabled := False;
                  btnExcluir.Enabled := False;
                  btnChqEmi.Enabled  := False;
                  btnAceOpe.Enabled  := False;
                End
                Else
                Begin
                  btnAlterar.Enabled := True;
                  btnExcluir.Enabled := True;
                  btnChqEmi.Enabled  := True;
                  btnAceOpe.Enabled  := True;
                End;
              End;
            End;
          End;
        End

      End

      {*****************************************}
      {* VALIDA A DATA INICIAL                 *}
      {**************************************MV*}
      Else If (Sender = dbeDtaIni) Then
      Begin
        objCadPor.strDtaIni := dbeDtaIni.Text;
      End

      {*****************************************}
      {* VALIDA O NOME DO PORTADOR             *}
      {**************************************MV*}
      Else If (Sender = dbeNomPor) Then
      Begin
        objCadPor.strNomPor := dbeNomPor.Text;
      End

      {*****************************************}
      {* VALIDA A CONTA CONTABIL               *}
      {**************************************LU*}
      Else If (Sender = dbeConCon) And (dbeConCon.Visible) Then
      Begin

        If Not fEmptyStr(objCadPor.fExisteConContabil) Then
        Begin
          If fMensagem('', 'Esta Conta Contábil está sendo utilizada por ( ' + objCadPor.fExisteConContabil +
                       ' ). Deseja continuar?', ['&Sim', '&Não']) = 2 Then
            Result := False;
        End;

      End

      Else If (Sender = dbePlaNco) And (dbePlaNco.Visible) Then
      Begin
        pCarregaPlanoContabil(blnBuscaPorChave);
        If (Not fEmptyStr(dbePlaNco.Text)) And (fEmptyStr(edtDesPlaNco.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
          Result := False;
        End
        Else If (qryTabela.State In [dsInsert, dsEdit]) Then
        begin
          If fEmptyStr(edtDesPlaNco.Text) Then
            dbePlaNco.Field.Value := Null
          Else
            dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
        end;
      End

      {**************************************}
      {* DIAS PARA CREDITO DO VALOR RECEBIDO*}
      {***********************************EL*}
      Else If (Sender = dbeDCrRec) Then
      Begin
        objCadPor.strDcrRec := dbeDcrRec.Text;
//        dbeDcrRec.Field.AsInteger := 0;
      End

      Else If (Sender = dbeCodBco) Then
      Begin
        If Not fEmptyStr(dbeCodBco.Text) Then
        Begin
          pCarregaBanco;
          If fEmptyStr(edtNomBan.Text) Then
          Begin
            fMensagem('','Nenhum banco cadastrado com este código', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          edtNomBan.Clear; 
          dbeCodBco.Field.Value := Null;
        End;
      End

      Else If (Sender = dbeCodigoFornecedorFiscal) And (dbeCodigoFornecedorFiscal.Visible) Then
      Begin
        edtNomeFornecedorFiscal.Clear;
        If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
        Begin
          CarregaFornecedorFiscal;
          If fEmptyStr(edtNomeFornecedorFiscal.Text) Then
          Begin
            fMensagem('ATENÇÃO','Fornecedor Fiscal não encontrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
  Begin
    pgcDados.ActivePage := tbsGeral;
    pSetFocus(Sender);
  End;

end;

procedure TfrmCadPortadores.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pInverterModalidades;
end;

procedure TfrmCadPortadores.lblModalidadesClick(Sender: TObject);
begin
  inherited;
  pAbrirPoup;
end;

procedure TfrmCadPortadores.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pMarcarModalidades(True);
end;

function TfrmCadPortadores.fCCaVinculada(strAutCCA: String): Boolean;
var
  qryCons: TUniquery;
begin
  Result := False;
  if not fEmptyStr(strAutCCA) then
  begin
    qryCons := fCriaQuery();

    with  qryCons do
    begin
      Sql.Clear;
      Sql.Text := 'SELECT * FROM CADPOR WHERE POR_CCAAUT = :CCAAUT AND POR_CODPOR <> :CODPOR';

      ParamByName('CCAAUT').AsString := strAutCCA;
      ParamByName('CODPOR').AsString := dbeCodPor.Text;

      Open;

      Result := RecordCount > 0;

      if Result then
        fMensagem('', 'A conta corrente selecionada está vinculada ao portador: ' + #13#13 + FieldByName('POR_CODPOR').AsString + ' - ' + FieldByName('POR_NOMPOR').AsString, ['&O K ']);

      Close;
    end;

    FreeAndNil(qryCons);
  end;
end;

function TfrmCadPortadores.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  Try
    GravaLogPor(qryTabela.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO', Self.Name);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadPortadores.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  end;
end;

function TfrmCadPortadores.fExisteLancamentoPendente: Boolean;
var
  qryCons: TUniQuery;
begin
  qryCons := fCriaQuery;

  If Not chkConOfx.Checked Then
    Exit(False);

  with qryCons do
  begin
    Sql.Clear;
    Sql.Text := 'SELECT * FROM MOVBAN WHERE CTB_DTACON IS NULL AND CTB_CODPOR = :CODPOR';
    ParamByName('CODPOR').AsString := dbeCodPor.Text;
    Open;

    Result := RecordCount > 0 ;

    Close;
    FreeAndNil(qryCons);
  end;
end;

procedure TfrmCadPortadores.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('POR_CODPOR');
  stlCampos.Add('POR_NOMPOR');
  stlCampos.Add('POR_DTAINI');
  stlCampos.Add('POR_ENTANA');
  stlCampos.Add('POR_CTRANA');
  stlCampos.Add('POR_ENTFLX');
  stlCampos.Add('POR_ENTPCO');
  stlCampos.Add('POR_TRANSF');
  stlCampos.Add('POR_SALPOR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('POR_NOMPOR');
  stlCamInd.Add('POR_CODPOR');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmCadPortadores.pInverterModalidades;
begin
  dbeModDin.Checked := Not dbeModDin.Checked;
  dbeModChv.Checked := Not dbeModChv.Checked;
  dbeModChp.Checked := Not dbeModChp.Checked;
  dbeModCar.Checked := Not dbeModCar.Checked;
  dbeModOrd.Checked := Not dbeModOrd.Checked;
  dbeModFin.Checked := Not dbeModFin.Checked;
end;

procedure TfrmCadPortadores.pMarcarDesmarcarEmpresas(blnMarcar: Boolean);
  Var
    intCnt: Integer;
begin
  For intCnt := 0 To clbEmpCnd.Count -1 Do
    clbEmpCnd.Checked[intCnt] := blnMarcar;
end;

procedure TfrmCadPortadores.pMarcarModalidades(blnMarcar: Boolean);
begin
  dbeModDin.Checked := blnMarcar;
  dbeModChv.Checked := blnMarcar;
  dbeModChp.Checked := blnMarcar;
  dbeModCar.Checked := blnMarcar;
  dbeModOrd.Checked := blnMarcar;
  dbeModFin.Checked := blnMarcar;
end;

procedure TfrmCadPortadores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('POR_ENTANA').AsString := 'N';
  qryTabela.FieldByName('POR_ENTFLX').AsString := 'N';
  qryTabela.FieldByName('POR_TRANSF').AsString := 'S';
  qryTabela.FieldByName('POR_DEPCHE').AsString := 'S';
  qryTabela.FieldByName('POR_ENTBOD').AsString := 'S';
  qryTabela.FieldByName('POR_BAIRCX').AsString := 'S';
  qryTabela.FieldByName('POR_BOLFAT').AsString := 'S';
  qryTabela.FieldByName('POR_PERTRA').AsString := 'S';
  qryTabela.FieldByName('POR_SALPOR').AsString := 'S';
  qryTabela.FieldByName('POR_CTRANA').AsString := 'N';
  qryTabela.FieldByName('POR_ENTPCO').AsString := 'N';
  qryTabela.FieldByName('POR_PERBAI').AsString := 'N';
  qryTabela.FieldByName('POR_MOVBAN').AsString := 'N';
  qryTabela.FieldByName('POR_BAIUTL').AsString := 'S';
  qryTabela.FieldByName('POR_EXIPOR').AsString := 'S';
  qryTabela.FieldByName('POR_CONPOR').AsString := 'S';
  qryTabela.FieldByName('POR_IMPBOL').AsString := 'S';
  qryTabela.FieldByName('POR_EXPAUT').AsString := 'S';
  qryTabela.FieldByName('POR_MODDIN').AsString := 'S';
  qryTabela.FieldByName('POR_MODCHV').AsString := 'S';
  qryTabela.FieldByName('POR_MODCHP').AsString := 'S';
  qryTabela.FieldByName('POR_MODCAR').AsString := 'S';
  qryTabela.FieldByName('POR_MODORD').AsString := 'S';
  qryTabela.FieldByName('POR_MODFIN').AsString := 'S';
  qryTabela.FieldByName('POR_TITPDD').AsString := 'N';
  qryTabela.FieldByName('POR_BAICTF').AsString := 'S';
  qryTabela.FieldByName('POR_ESTCTR').AsString := 'S';
  qryTabela.FieldByName('POR_CONOFX').AsString := 'S';
  qryTabela.FieldByName('POR_PERAUT').AsString := 'S';
  qryTabela.FieldByName('POR_BAICCD').AsString := 'S';

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodPor, dbeDtaIni, False)
  Else
    pHabilitaCodigo(dbeCodPor, dbeCodPor, True);
  qryTabela.FieldByName('POR_DTAINI').AsDateTime := VS_Date;

  pCarregaBanco;
  pCarregaCCa;
  pCarregaEmpresas;
  pCarregaPlanoDeContasPorEmpresa('PORNCO', dbeCodPor.Text, FcdsNCO);
  CarregaFornecedorFiscal;

  If cbxCarteira.Visible Then
  Begin
    pCarregarCarteirasBanco;
    pCarregaCarteiraBancoPortador;
    pSetaCarteiraBanco(qryCarPor.FieldByName('POR_CARTEI').AsString);
    cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  End;

  btnVincCCa.Enabled := qryTabela.State in [dsEdit,dsInsert];

  btnAceOpe.Enabled := True;
  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  clbEmpCnd.Enabled := True;
  pnlSelEmp.Visible := True;
end;

procedure TfrmCadPortadores.btnAceOpeClick(Sender: TObject);
begin
  inherited;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('','Você deve selecionar um portador para alterar as permissões de acesso dos operadores!', ['&Ok']);
    Exit;
  End;

  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('','Para alterar as permissões de acesso dos operadores você deve primeiro gravar o registro do novo portador!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmOperadoresPortador, frmOperadoresPortador);

  frmOperadoresPortador.strCodPor := dbeCodPor.Text;
  frmOperadoresPortador.ShowModal;

  FreeAndNil(frmOperadoresPortador);

  fValidaCampos(dbeCodPor);

end;

procedure TfrmCadPortadores.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pCarregaBanco;
  pCarregaCCa;
  pCarregaEmpresas;
  CarregaFornecedorFiscal;

  If cbxCarteira.Visible Then
  Begin
    pCarregarCarteirasBanco;
    pCarregaCarteiraBancoPortador;
    pSetaCarteiraBanco(qryCarPor.FieldByName('POR_CARTEI').AsString);
    cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  End;

  dbeCodPor.Enabled := False;
  dbeDtaIni.Enabled := fVerificaAcessoSistema('ALTDTAINIPOR');
  btnVincCCa.Enabled := qryTabela.State in [dsEdit,dsInsert];

  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  clbEmpCnd.Enabled := True;
  pnlSelEmp.Visible := True;

  If PortadorSemLogDeInclusao Then
  Begin
    GravaLogPor(qryTabela.FieldByName('AUTOINCREM').AsString,
                'INCLUSÃO',
                Self.Name,
                'AUT');
  End;

end;

procedure TfrmCadPortadores.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaBanco;
  pCarregaCCa;
  pCarregaEmpresas;
  pCarregaPlanoContabil;
  pCarregaPlanoDeContasPorEmpresa('PORNCO', dbeCodPor.Text, FcdsNCO);
  CarregaFornecedorFiscal;

  If cbxCarteira.Visible Then
  Begin
    pCarregarCarteirasBanco;
    pCarregaCarteiraBancoPortador;
    pSetaCarteiraBanco(qryCarPor.FieldByName('POR_CARTEI').AsString);
    cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  End;

  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  btnVincCCa.Enabled := False;
  clbEmpCnd.Enabled := False;
  pnlSelEmp.Visible := False;
end;

procedure TfrmCadPortadores.btnChqEmiClick(Sender: TObject);
  Var
    frmCadPorChqEmi: TfrmCadPorChqEmi;
begin
  inherited;
  If Not fEmptyStr(dbeCodPor.Text) Then
  Begin
    Try
      pCriarFormularios(TfrmCadPorChqEmi, frmCadPorChqEmi);
      frmCadPorChqEmi.strCodPor := dbeCodPor.Text;
      frmCadPorChqEmi.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadPortadores.btnChqEmiClick]');
    End;
    FreeAndNil(frmCadPorChqEmi);
  End
  Else
    pMensagemOk('Selecione um portador para prosseguir.');
end;

procedure TfrmCadPortadores.btnExcluirClick(Sender: TObject);
begin

  try
    pValidarExclusaoPortadorAutcom(dbeCodPor.Text, arrCamposCfg);
  except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', E.Message, ['&OK'], 1);
      Exit;
    end;
  end;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPortadores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaBanco;
  pCarregaCCa;
  pCarregaEmpresas;
  pCarregaPlanoContabil;
  pCarregaPlanoDeContasPorEmpresa('PORNCO', dbeCodPor.Text, FcdsNCO) ;
  CarregaFornecedorFiscal;

  If cbxCarteira.Visible Then
  Begin
    pCarregarCarteirasBanco;
    pCarregaCarteiraBancoPortador;
    pSetaCarteiraBanco(qryCarPor.FieldByName('POR_CARTEI').AsString);
    cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  End;

  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  btnVincCCa.Enabled := False;
  clbEmpCnd.Enabled := False;
  pnlSelEmp.Visible := False;
end;

procedure TfrmCadPortadores.btnGravarClick(Sender: TObject);
  Var
    blnInsert : Boolean;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnInsert := qryTabela.State = dsInsert;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if not fVerificarPlanoDeContasPorEmpresa(dbeCodPor.Text, 'PORNCO', dbePlaNco.Text, FcdsNCO) then
  begin
    exit ;
  end;

  if not fValidaPlanoDeContasObrigatoria(chkExpAut.Checked, fSemMascaraPlaNco(dbePlanco.Field.AsString), FcdsNCO) then
    Exit ;

  Try

    If fTiraCaracEspeciais(dbePlanco.Field.AsString) = '' Then
      dbePlanco.Field.Clear;

    if fEmptyStr(dbeCodigoFornecedorFiscal.Text) then
      qryTabela.FieldByName('POR_FORFIS').Value := Null;

    qryTabela.FieldByName('POR_EMPACE').AsString := fGetEmpSelecao;

    inherited;

    If blnGravou And cbxCarteira.Visible Then
      pSalvaCarteiraBancoPortador;

    If (blnGravou) And (blnInsert) Then
      pGravaOperadoresPortador;

    If blnGravou Then
    Begin
      pSalvaPlanoDeContasPorEmpresa('PORNCO', dbeCodPor.Text, FcdsNCO) ;
      If fCommit Then
        GravaLogPor(qryTabela.FieldByName('AUTOINCREM').AsString, IIF(blnInsert,'INCLUSÃO','ALTERAÇÃO'), Self.Name);
    End
    Else
      fRollBack;

    {**************************************************}
    {* ATUALIZA OS PORTADORES QUE A EMPRESA TEM ACESSO*}
    {***********************************************LE*}
    If fCfgSis('DACPOR', varBoolean) Then
      strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPortadores.btnGravarClick]');
    End;
  End;



  btnVincCCA.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  clbEmpCnd.Enabled := qryTabela.State in [dsEdit,dsInsert];
  pnlSelEmp.Visible := qryTabela.State in [dsEdit,dsInsert];

  CarregaFornecedorFiscal;
end;

procedure TfrmCadPortadores.FormShow(Sender: TObject);
begin
  inherited;

  If (Not fVerificaAcessoSistema('ALTDTAINIPOR')) Then
    shpAltDtaIni.Brush.Color  := clRed
  Else
    shpAltDtaIni.Brush.Color  := clGreen;

  pgcDados.ActivePageIndex := 0;

  lblCarteira.Visible := (fCfgSis('IMPBOL') = 'A')or(fCfgSis('BOLFIN', varBoolean));
  cbxCarteira.Visible := (fCfgSis('IMPBOL') = 'A')or(fCfgSis('BOLFIN', varBoolean));

  chkExiPor.Visible := fCfgSis('EXIPOR', VarString) = 'S';
  chkConPor.Visible := fCfgSis('EXIPOR', VarString) = 'S';

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  if not cbxCarteira.Visible then
  begin
    edtCCaVinc.Top := cbxCarteira.Top;
    lblCCaVinc.Top := lblCarteira.Top;
    btnVincCCA.Top := cbxCarteira.Top;
  end;

  If (blnUtiCon) Then
  Begin
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbeConCon.Visible := False;
    lblDesPlaCon.Caption := 'Plano Contábil:';
    btnPlaNco.Visible := True;
  End
  Else
  Begin
    dbePlaNco.Visible := False;
    edtDesPlaNco.Visible := False;
    dbeConCon.Visible := True;
    lblDesPlaCon.Caption := 'Conta Contábil:';
    btnPlaNco.Visible := False;
  End;

  If Not fEmptyStr(strCodPorIniciarCadastro) Then
  Begin
    Try
      dbeCodPor.Text := strCodPorIniciarCadastro;
      fValidaCampos(dbeCodPor, True);
    Finally
      strCodPorIniciarCadastro := '';
    End;
  End;

end;

procedure TfrmCadPortadores.pCarregarCarteirasBanco;
  Var
    intIndex : Integer;
begin
  SetLength(arrBanCar, 0);
  SetLength(arrBancos, 0);

  cbxCarteira.Items.Clear;

  If Not fEmptyStr(dbeCodBco.Text) Then
    pCarregaArrayBancoCarteira(dbeCodBco.Text, arrBancos, arrBanCar);

  For intIndex := Low(arrBancos) To High(arrbancos) Do
  Begin
    cbxCarteira.Items.Add(arrBanCar[intIndex]);
  End;

  cbxCarteira.Items.Add('Carteira padrão das configurações');
end;

procedure TfrmCadPortadores.pSetaCarteiraBanco(strCarteira: String);
  Var
    intIndex : Integer;
    strCarTmp: String;
begin
  cbxCarteira.ItemIndex := cbxCarteira.Items.Count -1;//Carteira padrão das configurações
  For intIndex := Low(arrBancos) To High(arrBancos) Do
  Begin
    strCarTmp := fGetChaveCarteiraBanco(intIndex);

    If strCarTmp = strCarteira Then
    Begin
      cbxCarteira.ItemIndex := intIndex;
      Break;
    End;
  End;
end;

procedure TfrmCadPortadores.pShowHint(chkControl: TDBCheckBox;
  strTitulo: String);
begin
  HintControler.ShowHint(Self.Left + chkControl.Left,
  Self.Top + 27 + chkControl.Top, strTitulo, chkControl.Hint);
end;

function TfrmCadPortadores.PortadorSemLogDeInclusao: Boolean;
  Var
    LQryLogPor : TUniQuery;
begin
  Result := False;

  If Not (qryTabela.State In [dsEdit]) Then
    Exit;

  Try
    LQryLogPor := fCriaQuery(Nil);
    Try
      LQryLogPor.Close;
      LQryLogPor.Sql.Clear;
      LQryLogPor.Sql.Add('SELECT * FROM LOGPOR WHERE POR_CODPOR = :CODPOR LIMIT 1');
      LQryLogPor.ParamByName('CODPOR').AsString := dbeCodPor.Text;
      LQryLogPor.Open;
      Result := LQryLogPor.IsEmpty;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LQryLogPor) Then
      FreeAndNil(LQryLogPor);
  End;
end;

function TfrmCadPortadores.fGetChaveCarteiraBanco(intIndex: Integer): String;
begin
  Result := '';
  If (Length(arrBancos) > 0) And (intIndex <= High(arrBancos)) Then
    Result := 'CONFIG' + arrBancos[intIndex].strCodBan + '-' +
                         arrBancos[intIndex].intCodCar.ToString + '-' + VS_strCodEmp;
end;

function TfrmCadPortadores.fGetEmpSelecao: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To clbEmpCnd.Count -1 Do
  Begin
    If (clbEmpCnd.Checked[intCnt]) Then
      Result := Result + LeftStr(clbEmpCnd.Items[intCnt], 3) + '_';
  End;
end;

function TfrmCadPortadores.fMovimentouExtratoEletronico: Boolean;
var
  qryCons: TUniQuery;
begin
  Result := False;

  if qryTabela.IsEmpty then
    Exit;

  qryCons := fCriaQuery;
  with qryCons do
  begin
    Sql.Clear;
    Sql.Text := 'SELECT AUTOINCREM FROM EXTBAN WHERE EXT_CODPOR = :CODPOR';
    ParamByName('CODPOR').AsString := dbeCodPor.Text;

    Open;

    Result := not IsEmpty;

    Close;
  end;

  FreeAndNil(qryCons);
end;

function TfrmCadPortadores.fMovimentouPix: Boolean;
var
  qryCons: TUniQuery;
begin
  Result := False;

  if qryTabela.IsEmpty then
    Exit;

  qryCons := fCriaQuery;
  try
    with qryCons do
    begin
      Sql.Clear;
      Sql.Add('SELECT p.* from CADPOR p');
      Sql.Add('  JOIN CADCCA cc ON cc.AUTOINCREM = p.POR_CCAAUT');
      Sql.Add('  JOIN CCAPIX cp ON cp.PIX_SEQCCA = cc.AUTOINCREM');
      Sql.Add('  JOIN MOVPIX m ON m.MPX_SEQPIX = cp.AUTOINCREM');
      Sql.Add('WHERE p.POR_CODPOR = :CODPOR');
      Sql.Add('LIMIT 1');

      ParamByName('CODPOR').AsString := dbeCodPor.Text;

      Open;

      Result := not IsEmpty;

      Close;
    end;
  finally
    FreeAndNil(qryCons);
  end;

end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCadPortadores.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  chrKey := '?';
  if fPesqPortador(conSimples,
                   Self,
                   nil,
                   nil,
                   qryTabela,
                   chrKey,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   '',
                   True) Then
  Begin
    If fValidaCampos(dbeCodPor) Then
    Begin
      If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        pSetFocus(btnAlterar);
      End;
    End;
  End;

  pCarregaBanco;
  pCarregaCCa;
  pCarregaEmpresas;
  btnVincCCa.Enabled := False;
  pCarregaPlanoContabil;
  pCarregaPlanoDeContasPorEmpresa('PORNCO', dbeCodPor.Text, FcdsNCO) ;
  CarregaFornecedorFiscal;

  If cbxCarteira.Visible Then
  Begin
    pCarregarCarteirasBanco;
    pCarregaCarteiraBancoPortador;
    pSetaCarteiraBanco(qryCarPor.FieldByName('POR_CARTEI').AsString);
    cbxCarteira.Enabled := qryTabela.State in [dsEdit,dsInsert];
  End;

  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
end;

procedure TfrmCadPortadores.btnPlaNcoClick(Sender: TObject);
begin
  pPlanoDeContasPorEmpresa(dbeCodPor.Text, 'PORNCO', qryTabela.FieldByName('POR_PLANCO').AsString, qryTabela.State, FcdsNCO, True);
end;

procedure TfrmCadPortadores.btnVincCCaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  chrKey: Char;
  qryConsCCa: TUniQuery;
begin
  if btnVincCCa.Caption = '&Vincular' then
  begin
    if fExisteLancamentoPendente then
    begin
       pMensagemOk('Existem lançamentos não conciliados na movimentação bancária para o portador selecionado!' + #13 + 'Para vincular o portador a uma conta corrente, é necessário que todos os lançamentos ' +
                   'do portador estejam conciliados!');
       Exit;
    end;

    qryConsCCa := fCriaQuery();
    chrKey := '?';
    if fPesqCCa(Self,
                qryConsCCa,
                chrKey,
                arrSel,
                dbeCodBco.Text)  then
    Begin
      if not fCCaVinculada(qryConsCCa.FieldByName('AUTOINCREM').AsString) then
      begin
        qryTabela.FieldByName('POR_CCAAUT').Value   := qryConsCCa.FieldByName('AUTOINCREM').AsString;

        if fEmptyStr(dbeCodBco.Text) then
        begin
          qryTabela.FieldByName('POR_CODBCO').Value := qryConsCCa.FieldByName('CCA_CODBCO').Value;
          pCarregaBanco;
        end;
      end
      else
        qryTabela.FieldByName('POR_CCAAUT').Value   := Null;

    End;

    pgcDados.ActivePage := tbsGeral;
    pSetFocus(dbeDCrRec);

    FreeAndNil(qryConsCCa);
  end
  else
  begin
    if fMensagem('', 'Confirma a desvinculação da conta corrente?', ['&S i m', 'N ã o'], 2) = 1 then
    begin
      if fMovimentouExtratoEletronico then
      begin
        pMensagemOk('Portador possui importação de extrato bancário! Não é possível desvincular a conta corrente!');
        Exit;
      end;

      if fMovimentouPix then
      begin
        pMensagemOk('Portador possui movimentação de pix bancário! Não é possível desvincular a conta corrente!');
        Exit;
      end;


      qryTabela.FieldByName('POR_CCAAUT').Value := Null;


    end;
  end;

  pCarregaCCa;

  pgcDados.ActivePage := tbsGeral;
  pSetFocus(dbeDCrRec);
end;

procedure TfrmCadPortadores.CarregaFornecedorFiscal;
begin
  edtNomeFornecedorFiscal.Clear;
  If Not fEmptyStr(dbeCodigoFornecedorFiscal.Text) Then
    edtNomeFornecedorFiscal.Text := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [dbeCodigoFornecedorFiscal.Text]);
end;

procedure TfrmCadPortadores.chkBaiUtlEnter(Sender: TObject);
begin
  inherited;
  chkBaiUtl.Hint := 'Este campo influencia somente em títulos baixados pelo' + #13+#10 +
                    'controle financeiro > baixa de contas a receber.';
  pShowHint(chkBaiUtl, 'Jogar a data do movimento bancário para o próximo dia útil');
end;

procedure TfrmCadPortadores.chkBaiUtlExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCadPortadores.chkConOfxClick(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCCaVinc.Text) And fExisteLancamentoPendente then
  begin
    pMensagemOk('Existem lançamentos não conciliados na movimentação bancária para o portador selecionado!' + #13 + 'Para utilizar a conciliação via extrato eletrônico, é necessário que todos os lançamentos ' +
                 'do portador estejam conciliados!');
    chkConOfx.Checked := False;
  end;
end;

function TfrmCadPortadores.dbeCodBcoChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadBco(Key);
end;

procedure TfrmCadPortadores.dbeCodBcoEnter(Sender: TObject);
begin
  inherited;
  objCadPor.strCodBco := dbeCodBco.Text;
end;

procedure TfrmCadPortadores.dbeCodBcoExit(Sender: TObject);
begin
  inherited;
  If objCadPor.strCodBco <> dbeCodBco.Text Then
  Begin
    objCadPor.strCodBco := dbeCodBco.Text;
    pCarregarCarteirasBanco;
    pSetaCarteiraBanco('');
  End;
end;

procedure TfrmCadPortadores.dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, dbeCodBco, edtNomBan, nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmCadPortadores.dbeCodigoFornecedorFiscalKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LFornecedorArray: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, dbeCodigoFornecedorFiscal, edtNomeFornecedorFiscal, Nil, Key, LFornecedorArray) Then
  Begin
    If fValidaCampos(dbeCodigoFornecedorFiscal, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPortadores.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('POR_PLANCO')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaNco, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('POR_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadPortadores.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pMarcarModalidades(False);
end;

procedure TfrmCadPortadores.dtsCadPorStateChange(Sender: TObject);
begin
  inherited;
  lblCompDescri.Enabled  := qryTabela.State in [dsEdit,dsInsert];
  lblModalidades.Enabled := qryTabela.State in [dsEdit,dsInsert];
  lblCompDescriEntPco.Enabled  := qryTabela.State in [dsEdit,dsInsert];
end;

procedure TfrmCadPortadores.pAbrirPoup;
begin
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadPortadores.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('POR_PLANCO') <> Nil Then
      TStringField(FieldByName('POR_PLANCO')).EditMask := fMskCon;
  end;
end;

procedure TfrmCadPortadores.pCarregaBanco;
begin
  edtNomBan.Text := fRetNomeBancoSelec(dbeCodBco.Text);
end;

procedure TfrmCadPortadores.pGravaOperadoresPortador;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  Try

    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO POROPE                        ';
    strSQL := strSQL + '   SELECT OPE_CODOPE,                      ';
    strSQL := strSQL + '        ' + QuotedStr(dbeCodPor.Text) + ', ';
    strSQL := strSQL + '        ' + QuotedStr('N')            + ', ';
    strSQL := strSQL + '            NULL                           ';
    strSQL := strSQL + '   FROM CADOPE                             ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + ' UPDATE POROPE SET OPE_ACESSO = ''S''      ';
    strSQL := strSQL + ' WHERE OPE_CODOPE = ' + QuotedStr(strLoginUsuarioLogado);
    strSQL := strSQL + ' AND OPE_CODPOR = ' + Quotedstr(dbeCodPor.Text);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
    End;

    //MF: 280817 - 17/05/2023 - ini
    strSQL := '';
    strSQL := strSQL + ' UPDATE POROPE ';
    strSQL := strSQL + '        SET OPE_ACESSO = ''S'' ';
    strSQL := strSQL + '        WHERE OPE_CODOPE IN ( ''999'', ''998'', ''997'', ''AUT'' ) AND '; //MA: 455267 - 18/09/2026
    strSQL := strSQL + '              OPE_CODPOR = '+ Quotedstr(dbeCodPor.Text);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
    End;
    //MF: 280817 - 17/05/2023 - fim

  Except
    fRollBack;
    Raise Exception.Create('Erro ao gravar operadores!');
  End;

end;

procedure TfrmCadPortadores.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmCadPortadores.pCarregaCarteiraBancoPortador;
begin
  With qryCarPor, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CARPOR WHERE POR_CODPOR = :CODPOR AND POR_CODEMP = :CODEMP');
    ParamByName('CODPOR').AsString := dbeCodPor.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
end;

procedure TfrmCadPortadores.pCarregaCCa;
var
  qryCCa: TUniQuery;
begin
  edtCCaVinc.Text := '';

  if not fEmptyStr(qryTabela.FieldByName('POR_CCAAUT').AsString) then
  begin
    btnVincCCa.Caption := '&Desvincular';
    qryCCa := fCriaQuery;

    with qryCCa do
    begin
      Sql.Clear;
      Sql.Text := ' SELECT * FROM CADCCA WHERE AUTOINCREM = :AUTOINC ';
      ParamByName('AUTOINC').AsString := qryTabela.FieldByName('POR_CCAAUT').AsString;

      Open;

      if Not IsEmpty then
      begin
        edtCCaVinc.Text :=  FieldByName('CCA_AGENCI').AsString;
        if not fEmptyStr(FieldByName('CCA_DIGAGE').AsString) then
           edtCCaVinc.Text := edtCCaVinc.Text + ' - ' + FieldByName('CCA_DIGAGE').AsString;

        edtCCaVinc.Text := edtCCaVinc.Text + ' / ' + FieldByName('CCA_CODCTA').AsString;
        if not fEmptyStr(FieldByName('CCA_DIGCTA').AsString) then
           edtCCaVinc.Text := edtCCaVinc.Text + ' - ' + FieldByName('CCA_DIGCTA').AsString;
      end;
    end;

    FreeAndNil(qryCCa);
  end
  else
    btnVincCCa.Caption := '&Vincular';
end;

procedure TfrmCadPortadores.pCarregaEmpresas;
begin
  pCarregaListaEmpresas(clbEmpCnd, fGetEmpAceCadPor(qryTabela.FieldByName('POR_CODPOR').AsString));
end;

procedure TfrmCadPortadores.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) Then
  begin
    edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
  end;
end;

procedure TfrmCadPortadores.pSalvaCarteiraBancoPortador;
begin
  With qryCarPor, SQL Do
  Begin
    Close;
    Clear;
    Add('DELETE FROM CARPOR WHERE POR_CODPOR = :CODPOR AND POR_CODEMP = :CODEMP');
    ParamByName('CODPOR').AsString := dbeCodPor.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ExecSQL;

    If Not fEmptyStr(fGetChaveCarteiraBanco(cbxCarteira.ItemIndex)) Then
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CARPOR WHERE FALSE');
      Open;

      qryCarPor.Append;

      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CARPOR',VS_strCodEmp);
      FieldByName('POR_CODPOR').AsString := dbeCodPor.Text;
      FieldByName('POR_CODEMP').AsString := VS_strCodEmp;
      FieldByName('POR_CARTEI').AsString := fGetChaveCarteiraBanco(cbxCarteira.ItemIndex);

      qryCarPor.Post;
    End;
  End;
end;

end.

