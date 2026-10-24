{*****************************************}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadDacBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDacBases = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodFml: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label3: TLabel;
    dbeCodUni: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    edtDesUni: TEditFocus;
    edtSigUni: TEditFocus;
    Label5: TLabel;
    dbePreCus: TDBEditFocus;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    Label6: TLabel;
    dbeMargem: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure dbePreCusExit(Sender: TObject);
    procedure dbeMargemExit(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;

    dtsCadBas: TDataSource;
    procedure pCarregaItem;
    procedure pCarregaUnidade;
    procedure pHabilitaBtn;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pLigaDataSets;    
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadDacBases: TfrmCadDacBases;

implementation

uses  untModuloTinta,  untPesqAux,
      untPai,
      untFuncoesSimples, untFuncTinta,
      untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadDacBases.FormCreate(Sender: TObject);
begin
  inherited;

  dtsCadBas := fCriaDataSource(frmModuloTinta.qryDac_CadBas);
  pLigaDataSets;

  qryTabela     := frmModuloTinta.qryDac_CadBas;
  strNomeTabela := 'DAC_CADBAS';
  strNomeCampo  := 'BAS_CODFML';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsDac_CadBas;

  TFloatField(frmModuloTinta.qryDac_CadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(frmModuloTinta.qryDac_CadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeCodFml;
  arrCamposChave[1] := dbeBase;
  arrCamposChave[2] := dbeCodUni;
  arrCamposChave[3] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadDacBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeCodFml) Then
    Begin

      If (fEmptyStr(dbeCodFml.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    Else If (Sender = dbeBase) Then
    Begin

      If (fEmptyStr(dbeBase.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A UNIDADE                      *}
    {**************************************MV*}
    Else If (Sender = dbeCodUni) Then
    Begin

      If (fEmptyStr(dbeCodUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaUnidade;
        If (fEmptyStr(edtDesUni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Unidade não utilizada pela tinta Dacar!', ['&O k']);
          Result := False;
        End;
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

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

//      If (fEmptyStr(dbeCodIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'O Item Base deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
//      Else
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        pCarregaItem;
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'DAC_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End
        Else If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Not fEmptyStr(dbeCodIte.Text)) Then
    Begin
      {*****************************************}
      {* VALIDA O PREÇO DE CUSTO               *}
      {**************************************MV*}
      If (Sender = dbePreCus) Then
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

      End

      {*****************************************}
      {* VALIDA A MARGEM                       *}
      {**************************************MV*}
      Else If (Sender = dbeMargem) Then
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

      End

      {*****************************************}
      {* VALIDA O PREÇO DE VENDA               *}
      {**************************************MV*}
      Else If (Sender = dbePreVen) Then
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
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadDacBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
  pHabilitaBtn;
end;

procedure TfrmCadDacBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODFML');
  stlCampos.Add('BAS_BASE__');
  stlCampos.Add('BAS_UNIDAD');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_BASE__');
  stlCamInd.Add('BAS_CODFML');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código da Fórmula');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');



end;

procedure TfrmCadDacBases.pLigaDataSets;
  Var
    intCont: Integer;
begin
  {***********************************************************}
  {* LIGA TODOS OS DBEDITS NO DATASOUCE CRIADO DINAMICAMENTE *}
  {********************************************************PH*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End;
  End;
end;

procedure TfrmCadDacBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDacBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodFml);
  edtDesIte.Clear;
  edtDesUni.Clear;
  edtSigUni.Clear;
  pHabilitaBtn;
end;

procedure TfrmCadDacBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  key := '/';
  If fPesqBaseTinta(Self, conDac, dbeBase, nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaUnidade;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDacBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaUnidade;
end;

procedure TfrmCadDacBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaUnidade;
end;

procedure TfrmCadDacBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodFml.Enabled := False;
  dbeBase.Enabled := False;
  dbeCodUni.Enabled := False;
  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
  pHabilitaBtn;
end;

procedure TfrmCadDacBases.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeCodUni, edtDesUni, nil, nil, Key, arrSel) Then
    If fValidaCampos(dbeCodUni, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDacBases.dbeMargemExit(Sender: TObject);
begin
  inherited;
  dbeMargem.Text := FormatFloat('#0.00', fStrToFloat(dbeMargem.Text));
end;

procedure TfrmCadDacBases.dbePreCusExit(Sender: TObject);
begin
  inherited;
  dbePreCus.Text := FormatFloat('#0.00', fStrToFloat(dbePreCus.Text));
end;

procedure TfrmCadDacBases.pCarregaUnidade;
  Var
    qryCadUni : TUniQuery;
begin
  Try
    qryCadUni := fCriaQuery(Self);
    qryCadUni.SQL.Clear;
    qryCadUni.SQL.Add('SELECT');
    qryCadUni.SQL.Add(' DAC_UNIDAC, UNI_DESUNI, UNI_SIGUNI');
    qryCadUni.SQL.Add('FROM');
    qryCadUni.SQL.Add(' DAC_UNIDAC');
    qryCadUni.SQL.Add(' INNER JOIN CADUNI');
    qryCadUni.SQL.Add(' ON DAC_UNIDAC.DAC_UNIAUT = CADUNI.UNI_CODUNI');
    qryCadUni.SQL.Add('WHERE');
//    qryCadUni.SQL.Add(' DAC_UNIDAC = :UNIAUT');
    qryCadUni.SQL.Add(' DAC_UNIAUT = :UNIAUT');
    qryCadUni.ParamByName('UNIAUT').AsString := dbeCodUni.Text;
    qryCadUni.Open;

    edtDesUni.Text := qryCadUni.FieldByName('UNI_DESUNI').AsString;
    edtSigUni.Text := qryCadUni.FieldByName('UNI_SIGUNI').AsString;
  Finally
    FreeAndNil(qryCadUni);
  End;
end;

procedure TfrmCadDacBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadDacBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtn;
end;

procedure TfrmCadDacBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
//  dbeDescri.Field.AsString := qryCon002.FieldByName('ITE_DESITE').AsString;
  dbePreCus.Field.AsFloat  := fltPrecus;
  dbeMargem.Field.AsFloat  := fltMargem;
  dbePreVen.Field.AsFloat  := fltPreVen;
end;

function TfrmCadDacBases.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadDacBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

end.

