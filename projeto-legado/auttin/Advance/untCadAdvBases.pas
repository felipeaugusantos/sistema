unit untCadAdvBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAdvBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnRestPreco: TSpeedButton;
    pnlCabecalho: TPanel;
    edtDesIte: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    Label3: TLabel;
    dbeUnidade: TDBEditFocus;
    edtUnidade: TEditFocus;
    edtCodUni: TEditFocus;
    Label4: TLabel;
    dbePesEsp: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeUnidadeExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;

    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pbtnRestaura;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadAdvBases: TfrmCadAdvBases;

implementation

uses untFuncoesSimples, untPai,
     untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAdvBases }

function TfrmCadAdvBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
        Result := (fMensagem('ATENÇÃO', 'O código da base deve ser informado!', ['OK']) = -1)
    End

    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
        Result := (fMensagem('ATENÇÃO', 'A descrição da base deve ser informada!', ['OK']) = -1);
    End

    Else If Sender = dbeUnidade Then
    Begin
      pCarregaUnidade;

      If fEmptyStr(dbeUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A unidade deve ser preenchida!', ['OK']) = -1;
      End

      Else If fEmptyStr(edtUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A unidade não é válida!', ['OK']) = -1;
      End;
    End

//    Else If Sender = dbePesEsp Then
//    Begin
//      If fEmptyStr(dbePesEsp.Text) Then
//        Result := fMensagem('ATENÇÃO', 'O peso específico deve ser informado!', ['OK']) = -1
//      Else If fStrToFloat(dbePesEsp.Text) <= 0  Then
//        Result := fMensagem('ATENÇÃO', 'O peso específico deve ser maior que zero!', ['OK']) = -1;
//    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If Sender = dbeCodIte Then
      Begin
        pCarregaItem;

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O item não está cadastrado!', ['OK']) = -1;
        End
        Else If Not fItemAtivo(dbeCodIte.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O item não está ativo', ['OK']) = -1;
        End
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'ADV_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado com outra base!'#10#13'Deseja Continuar?', ['Sim', 'Não']) = 1;
        End;
      End

      Else If Sender = dbePreCus Then
      Begin
        If fEmptyStr(dbePreCus.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custos deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreCus.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custo deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End

      Else If Sender = dbePreVen Then
      Begin
        If fEmptyStr(dbePreVen.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreVen.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End

      Else If Sender = dbeMargem Then
      Begin
        If fEmptyStr(dbeMargem.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbeMargem.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdvBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadAdvBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'ADV_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeUnidade;
end;

procedure TfrmCadAdvBases.pCriaDataSets;
begin

  qryCadBas := fCriarQuery('SELECT * FROM ADV_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldbyName('BAS_DESCRI').DisplayLabel := 'Descrição';
  qryCadBas.FieldbyName('BAS_UNIDAD').DisplayLabel := 'Unidade';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.00';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadAdvBases.pLigaDataSets;
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

procedure TfrmCadAdvBases.pCarregaUnidade;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT UNI_DESUNI, UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI';
  qryGen.ParamByName('CODUNI').AsString := dbeUnidade.Text;
  qryGen.Open;
  edtUnidade.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
  edtCodUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
end;

procedure TfrmCadAdvBases.dbeUnidadeExit(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
end;

procedure TfrmCadAdvBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conADV, nil, nil, qrytabela, key, arrSel, True, '', 'BAS_CODITE', False) Then
  Begin
    pCarregaItem;
    pCarregaUnidade;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAdvBases.pCarregaItem;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := dbeCodIte.Text;
  qryGen.Open;
  edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  
  FreeAndNil(qryGen);
end;

procedure TfrmCadAdvBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pSetFocus(dbeCodigo);
end;

function TfrmCadAdvBases.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadAdvBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  pSetFocus(dbeCodigo);
end;

procedure TfrmCadAdvBases.dbeUnidadeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeUnidade, nil, nil, nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
    fValidaCampos(dbeUnidade, True);
  End;
end;

procedure TfrmCadAdvBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAdvBases.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadBas.State = dsEdit;
end;

procedure TfrmCadAdvBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdvBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdvBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadAdvBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

end.

