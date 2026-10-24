{*****************************************}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadStaBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, Uni, AppEvnts, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadStaBases = class(TfrmPaiCad)
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbePreCus: TDBEditFocus;
    Label6: TLabel;
    dbeMargem: TDBEditFocus;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    btnRestPreco: TSpeedButton;
    Label1: TLabel;
    dbeVolume: TDBEditFocus;
    lblPesEsp: TLabel;
    dbePesEsp: TDBEditFocus;
    dtsStaCadBas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;
    conf: IConfTinta;
    StrCodIteAnt : String;

    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pHabilitaBtn;
    procedure pAtualizarFatortintometrico;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadStaBases: TfrmCadStaBases;

implementation

uses untModuloTinta, untPesqAux,
  untPai,
  untFuncTinta, untFuncoesSimples,
  untConsultas, untTypesSistema, untValidarBaseItemAmarracao;

{$R *.dfm}

procedure TfrmCadStaBases.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qrySta_CadBas;
  conf          := fGetConfTinta('STA');
  strNomeTabela := 'STA_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  dtsStaCadBas.DataSet := frmModuloTinta.qrySta_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsSta_CadBas;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeBase;
  arrCamposChave[1] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);

  dbePesEsp.DataField := 'BAS_PESESP';
  dbePesEsp.Visible := True;
  lblPesEsp.Visible := True;
end;

procedure TfrmCadStaBases.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

{*****************************************}
{* CALCULA O PREÇO DE VENDA              *}
{**************************************MV*}
function TfrmCadStaBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin

  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadStaBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    If (Sender = dbeBase) Then
    Begin

      If (fEmptyStr(dbeBase.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        fBuscaPorCamposChave;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbeVolume) Then
    Begin

      If (fEmptyStr(dbeVolume.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O volume deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeVolume.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O volume deve maior que Zero!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        pCarregaItem;
        If (Not fItemAtivo(dbeCodIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item está inativo!', ['&O k']);
          Result := False;
        End
        Else If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
          If (qryTabela.State = dsInsert) And (blnBuscaPorChave) Then
          Begin
            dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
            dbePreCus.Field.AsFloat  := fltPrecus;
            dbeMargem.Field.AsFloat  := fltMargem;
            dbePreVen.Field.AsFloat  := fltPreVen;
          End;
        End;
      End
    End

    {*****************************************}
    {* VALIDA O PREÇO DE CUSTO               *}
    {**************************************MV*}
    Else If (Sender = dbePreCus) Then
    Begin

      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A MARGEM                       *}
    {**************************************MV*}
    Else If (Sender = dbeMargem) Then
    Begin

      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O PREÇO DE VENDA               *}
    {**************************************MV*}
    Else If (Sender = dbePreVen) Then
    Begin

      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;
      End;

    End

    Else If (Sender = dbePesEsp) And (dbePesEsp.Visible) Then
    Begin
      If fEmptyStr(dbePesEsp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher peso específico.', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(dbePesEsp.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O peso específico deve ser maior que Zero.', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadStaBases.pAtualizarFatortintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                                                  ' +
        '   CADITE I                                              ' +
        '   INNER JOIN STA_CADBAS B                               ' +
        '     ON I.ITE_CODITE = B.BAS_CODITE SET I.ITE_CNV_ML = ( ' +
        '       IFNULL(BAS_PESESP, 1) * IFNULL(BAS_VOLUME, 3600)  ' +
        '     )                                                   ';
      qryGen.ExecSQL;
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

procedure TfrmCadStaBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadStaBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESBAS');
  stlCampos.Add('BAS_VOLUME');
  stlCampos.Add('BAS_PRECUS');
  stlCampos.Add('BAS_MARGEM');
  stlCampos.Add('BAS_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadStaBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
end;

procedure TfrmCadStaBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadStaBases.btnIncluirClick(Sender: TObject);
begin
  StrCodIteAnt := '';
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeBase);

  edtDesIte.Clear;

  pHabilitaBtn;
end;

procedure TfrmCadStaBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  key := '/';
  If fPesqBaseTinta(Self, conSta, Nil, Nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadStaBases.btnExcluirClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;;
  inherited;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'STA');

  pCarregaItem;
end;

procedure TfrmCadStaBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadStaBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;
  dbeBase.Enabled := False;
  pSetFocus(dbeVolume);
  pHabilitaBtn;
end;

procedure TfrmCadStaBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
  dbePreCus.Field.AsFloat  := fltPrecus;
  dbeMargem.Field.AsFloat  := fltMargem;
  dbePreVen.Field.AsFloat  := fltPreVen;
end;

procedure TfrmCadStaBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;

  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadStaBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (dtsStaCadBas.DataSet.State in [dsEdit]);

  Try
    fStartTransaction;

    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('STA', dbeBase.text, dbeDescri.text, dbeCodIte.Text , StrCodIteAnt ,
         dtsStaCadBas.DataSet.FieldByName('BAS_PESESP').AsFloat , fStrToFloat(dbeVolume.Text)) Then
    begin
      inherited;
      pHabilitaBtn;
      pAtualizarFatortintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'STA');
      End;


      fCommit;
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

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

end.

