unit untCadEucBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, EditFocus, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEucBases = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeProdBas: TDBEditFocus;
    Label3: TLabel;
    dbeIteBas: TDBEditFocus;
    Label4: TLabel;
    dbeUniBas: TDBEditFocus;
    Label5: TLabel;
    dbePreCusBas: TDBEditFocus;
    Label6: TLabel;
    dbeMargBas: TDBEditFocus;
    Label7: TLabel;
    dbePreVenBas: TDBEditFocus;
    edtDesIte: TEditFocus;
    edtDesUni: TEditFocus;
    edtCodUni: TEditFocus;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dbeIteBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeUniBasKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeIteBasExit(Sender: TObject);
    procedure dbeUniBasExit(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    qryCadUni: TUniQuery;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaIte;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaUni;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmCadEucBases: TfrmCadEucBases;

implementation

uses untFuncoesSimples, untPai, untFuncTinta,
  untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEucBases.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}
  qryCadUni := fCriarQuery('SELECT * FROM CADUNI', Self);

  qryCadBas := fCriarQuery('SELECT * FROM EUC_CADBAS', Self);
  qryCadBas.FieldByName('BAS_DESCRI').DisplayLabel := 'Base';
  qryCadBas.FieldbyName('BAS_PRODUT').DisplayLabel := 'Produto';
  qryCadBas.FieldbyName('BAS_CODUNI').DisplayLabel := 'Unidade';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;
  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';


  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadEucBases.pLigaDataSets;
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

  {**************************************}
  {* LUGA OS DBEDITS NOS DEVIDOS CAMPOS *}
  {***********************************PH*}
  dbeCodBas.DataField := 'BAS_DESCRI';
  dbeIteBas.DataField := 'BAS_CODITE';
  dbeMargBas.DataField := 'BAS_MARGEM';
  dbePreCusBas.DataField := 'BAS_PRECUS';
  dbePreVenBas.DataField := 'BAS_PREVEN';
  dbeProdBas.DataField := 'BAS_PRODUT';
  dbeUniBas.DataField := 'BAS_CODUNI';

end;

procedure TfrmCadEucBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'EUC_CADBAS';
  strNomeCampo := 'BAS_DESCRI';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodBas;
  arrCamposChave[1] := dbeProdBas;
end;

procedure TfrmCadEucBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_PRODUT');
  stlCampos.Add('BAS_CODUNI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_PRODUT');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Base/Produto');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;



function TfrmCadEucBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVenBas.Text) Then
    dbePreVenBas.Text := '0,00';

  If fEmptyStr(dbeMargBas.Text) Then
    dbeMargBas.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCusBas.Text),
                               fStrToFloat(dbePreVenBas.Text),
                               fStrToFloat(dbeMargBas.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadEucBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodBas) Then
    Begin
      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A base deve ser preenchida', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeProdBas) Then
    Begin
      If (fEmptyStr(dbeProdBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O produto deve ser preenchido', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeIteBas) Then
    Begin
      pCarregaIte;
//      If (fEmptyStr(dbeIteBas.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO', 'O item deve ser preenchido', ['OK']);
//        Result := False;
//      End
//      Else If (fEmptyStr(edtDesIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO', 'Esse item não está cadastrado', ['OK']);
//        Result := False;
//      End
      If Not fEmptyStr(dbeIteBas.Text) Then
      Begin
        If fExisteValorNoCampo(dbeIteBas.Text, 'BAS_CODITE', 'EUC_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End

        Else If Not (fItemAtivo(dbeIteBas.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está ativo', ['OK']);
          Result := False;
        End;
      End;

    End


    Else If Not fEmptyStr(dbeIteBas.Text) Then
    Begin
      If (Sender = dbePreCusBas) Then
      Begin
        If (fEmptyStr(dbePreCusBas.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de custo deve ser preenchido', ['OK']);
          Result := False;
        End

        Else If (fStrToFloat(dbePreCusBas.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de custo dever ser maior que zero', ['OK']);
          Result := false;
        End

        Else
          dbePreVenBas.Field.AsFloat := fRetPrecoVenda(1);
      End
      Else If (Sender = dbePreVenBas) Then
      Begin
        If (fEmptyStr(dbePreVenBas.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de venda dever ser preenchido', ['OK']);
          Result := False;
        End

        Else If (fStrToFloat(dbePreVenBas.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero', ['OK']);
          Result := False;
        End

        Else
          dbeMargBas.Field.AsFloat := fRetPrecoVenda(2);
      End
      Else If (Sender = dbeMargBas) Then
      Begin

        If (fEmptyStr(dbeMargBas.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A margem deve ser preenchida', ['OK']);
          Result := False;
        End

        Else If (fStrToFloat(dbeMargBas.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'A margem deve ser maior que zero', ['OK']);
          Result := False;
        End

        Else
          dbePreVenBas.Field.AsFloat := fRetPrecoVenda(1);
      End
    End


    Else If (Sender = dbeUniBas) Then
    Begin
      pCarregaUni;
      If (fEmptyStr(dbeUniBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A unidade deve ser preenchida', ['OK']);
        Result := False;
      End
      Else If (fEmptyStr(edtDesUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A unidade não está cadastrada', ['OK']);
        Result := False;
      End;
    End;
  End;

    If Not (Result) Then
      pSetFocus(Sender);

end;

procedure TfrmCadEucBases.dbeIteBasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeIteBas, nil, nil,Key, arrSel) Then
  begin
    pCarregaIte;
    btnRestPreco.Click;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEucBases.dbeUniBasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeUniBas, Nil, Nil, nil, Key, arrSel) Then
  Begin
    SelectNext(ActiveControl, True, True);
    fValidaCampos(dbeUniBas, True);
  End;
end;

procedure TfrmCadEucBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeIteBas.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCusBas.Field.AsFloat := fltPrecus;
  dbeMargBas.Field.AsFloat := fltMargem;
  dbePreVenBas.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadEucBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conEuc, nil, nil , qryTabela, Key, arrSel, True, '', 'BAS_CODITE', False) Then
  Begin
    pCarregaIte;
    pCarregaUni;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadEucBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State = dsEdit Then
  Begin
    pSetFocus(dbeCodBas);
    btnRestPreco.Visible := True;
  End;
end;

procedure TfrmCadEucBases.btnGravarClick(Sender: TObject);
begin
  If fEmptyStr(dbeIteBas.Text) Then
    qryTabela.FieldByName('BAS_CODITE').Value := Null;
  inherited;
  btnRestPreco.Visible := False;
end;

procedure TfrmCadEucBases.pCarregaUni;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT UNI_DESUNI, UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI', Self);
  qryGen.ParamByName('CODUNI').AsString := dbeUniBas.Text;
  qryGen.Open;
  edtDesUni.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
  edtCodUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
  FreeAndNil(qryGen);
//SELECT UNI_DESUNI, UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI
end;

procedure TfrmCadEucBases.dbeIteBasExit(Sender: TObject);
begin
  inherited;
  pCarregaIte;
end;

procedure TfrmCadEucBases.dbeUniBasExit(Sender: TObject);
begin
  inherited;
  pCarregaUni;
end;

procedure TfrmCadEucBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodBas);

  pCarregaIte;
  pCarregaUni;
end;

procedure TfrmCadEucBases.pCarregaIte;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODUNI';
  qryGen.ParamByName('CODUNI').AsString := dbeIteBas.Text;
  qryGen.Open;
  edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmCadEucBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaIte;
  pCarregaUni;
end;

procedure TfrmCadEucBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaIte;
  pCarregaUni;
end;

end.

