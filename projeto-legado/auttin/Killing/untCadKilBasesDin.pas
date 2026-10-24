unit untCadKilBasesDin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadKilBasesDin = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnRestPreco: TSpeedButton;
    edtDesIte: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    Label3: TLabel;
    dbeUnidade: TDBEditFocus;
    lblBase: TLabel;
    dbeBase: TDBEditFocus;
    Label4: TLabel;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
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
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pbtnRestaura;
    function fUnidadePermitida(strUnidade: String): Boolean;
    function fRetEmbalagem(strUnidade: String): Double;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadKilBasesDin: TfrmCadKilBasesDin;

implementation

uses untFuncoesSimples, untPai,
    untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadKilBasesDin }

function TfrmCadKilBasesDin.fValidaCampos(Sender: TWinControl;
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

      If fEmptyStr(dbeUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A unidade deve ser preenchida!', ['OK']) = -1;
      End
      Else If (Not fUnidadePermitida(dbeUnidade.Text)) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Essa embalagem não pode ser cadastrada!', ['OK']) = -1;
      End
      Else
      Begin
        If Assigned(qryCadBas) And (Not fEmptyStr(dbeUnidade.Text)) Then
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat := fRetEmbalagem(dbeUnidade.Text);
      End;
      
    End

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
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'KILD_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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

procedure TfrmCadKilBasesDin.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODFML');
  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODFML');
  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Base');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadKilBasesDin.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'KILD_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeUnidade;
end;

procedure TfrmCadKilBasesDin.pCriaDataSets;
begin

  qryCadBas := fCriarQuery('SELECT * FROM KILD_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODFML').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Base';
  qryCadBas.FieldbyName('BAS_DESCRI').DisplayLabel := 'Descrição';
  qryCadBas.FieldbyName('BAS_CODUNI').DisplayLabel := 'Embalagem';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';


  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadKilBasesDin.pLigaDataSets;
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

procedure TfrmCadKilBasesDin.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conKil, nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadKilBasesDin.pCarregaItem;
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

procedure TfrmCadKilBasesDin.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pSetFocus(dbeCodigo);
  dbeUnidade.Enabled := False;
end;

function TfrmCadKilBasesDin.fRetEmbalagem(strUnidade: String): Double;
begin
  Result := 810;

  if strUnidade = 'M18' then
    Result := 16200
  Else if strUnidade = 'L18' then
    Result := 16200
  Else if strUnidade = 'P18' then
    Result := 16200
  Else if strUnidade = 'GM' then
    Result := 3240
  Else if strUnidade = 'LT9' then
    Result := 810;
end;

function TfrmCadKilBasesDin.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadKilBasesDin.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  pSetFocus(dbeCodigo);

  edtDesIte.Clear;

  dbeUnidade.Enabled := True;
end;

procedure TfrmCadKilBasesDin.dbeUnidadeKeyPress(Sender: TObject;
  var Key: Char);

Const
  arrEmbs: Array[1..5] of String    = ('M18', 'L18', 'GM', 'P18', 'LT9');
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    dbeUnidade.Text := arrEmbs[fGetMenu('Escolha uma Embalagem', arrEmbs, 1)];

    If Assigned(qryCadBas) And (Not fEmptyStr(dbeUnidade.Text)) Then
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat := fRetEmbalagem(dbeUnidade.Text);
  End;
end;

function TfrmCadKilBasesDin.fUnidadePermitida(strUnidade: String): Boolean;
begin
  Result := (strUnidade = 'M18') Or (strUnidade = 'L18') Or
            (strUnidade = 'GM')  Or (strUnidade = 'P18') Or
            (strUnidade = 'LT9');
end;

procedure TfrmCadKilBasesDin.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadKilBasesDin.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadBas.State = dsEdit;
end;

procedure TfrmCadKilBasesDin.btnGravarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadKilBasesDin.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pCarregaItem
end;

procedure TfrmCadKilBasesDin.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadKilBasesDin.btnExcluirClick(Sender: TObject);
begin
  inherited;
  edtDesIte.Clear;
  pbtnRestaura;
end;

end.

