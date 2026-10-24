unit untCadEucColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, EditFocus, Mask, DBCtrls, DBEditFocus,
  Buttons, AppEvnts, Menus, ComCtrls, ExtCtrls, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEucColorantes = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnRestPreco: TSpeedButton;
    dbeCodCol: TDBEditFocus;
    pnlCabecalho: TPanel;
    dbeIteCol: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    dbeEmbala: TDBEditFocus;
    procedure dbeIteColKeyPress(Sender: TObject; var Key: Char);
    procedure dbeIteColExit(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    qryCadCol: TUniQuery;
    dtsCadCol: TDataSource;

    strCodIteAnt : String;

    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaIte;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    { Private declarations }
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
    procedure pAtualizaFatorTintometrico;
  end;

var
  frmCadEucColorantes: TfrmCadEucColorantes;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadEucColorantes }

function TfrmCadEucColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadEucColorantes.pCarregaIte;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := dbeIteCol.Text;
  qryGen.Open;
  edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmCadEucColorantes.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadCol := fCriarQuery('SELECT * FROM EUC_CADCOL', Self);
  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Colorante';
  qryCadCol.FieldbyName('COL_CODITE').DisplayLabel := 'Item';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;
  TFloatField(qryCadCol.FieldByName('COL_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_MARGEM')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_EMBALA')).DisplayFormat := '0.0000';

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadEucColorantes.pLigaDataSets;
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
      (Components[intCont] as TDBEdit).DataSource := dtsCadCol;
    End;
  End;

  {**************************************}
  {* LUGA OS DBEDITS NOS DEVIDOS CAMPOS *}
  {***********************************PH*}

  dbeCodCol.DataField := 'COL_CODCOL';
  dbeIteCol.DataField := 'COL_CODITE';
  dbeMargem.DataField := 'COL_MARGEM';
  dbePreCus.DataField := 'COL_PRECUS';
  dbePreVen.DataField := 'COL_PREVEN';
  dbeEmbala.DataField := 'COL_EMBALA';
end;

procedure TfrmCadEucColorantes.dbeIteColKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeIteCol, edtDesIte, nil, Key, arrSel) Then
  Begin
    btnRestPreco.Click;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEucColorantes.dbeIteColExit(Sender: TObject);
begin
  inherited;
  pCarregaIte;
end;

procedure TfrmCadEucColorantes.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeIteCol.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadEucColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'EUC_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCol;
end;

function TfrmCadEucColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodCol) Then
    Begin
      If (fEmptyStr(dbeCodCol.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O colorante deve ser preenchida', ['OK']);
        Result := False;
      End;
    End
    Else If (Sender = dbePreVen) Then
    Begin
      If Not fEmptyStr(dbeIteCol.Text) Then
      Begin
        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de venda dever ser preenchido', ['OK']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero', ['OK']);
          Result := False;
        End
        Else
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End
      Else
        dbePreVen.Text := '';
    End
    Else If (Sender = dbeMargem) Then
    Begin
      If Not fEmptyStr(dbeIteCol.Text) Then
      Begin
        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A margem deve ser preenchida', ['OK']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'A margem deve ser maior que zero', ['OK']);
          Result := False;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End
      Else
        dbeMargem.Text := '';
    End
    Else If (Sender = dbeIteCol) Then
    Begin
      pCarregaIte;
      If Not fEmptyStr(dbeIteCol.Text) Then
      Begin
        If fExisteValorNoCampo(dbeIteCol.Text, 'COL_CODITE', 'EUC_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End
        Else If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está cadastrado', ['OK']);
          Result := False;
        End
        Else If Not (fItemAtivo(dbeIteCol.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está ativo', ['OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeEmbala) Then
    Begin
      If (fEmptyStr(dbeEmbala.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida', ['OK']);
        Result := False;
      End
      Else If (fStrToFloat(dbeEmbala.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser maior que zero', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEucColorantes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_CODITE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('COL_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadEucColorantes.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';

  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodCol);

  pCarregaIte;
end;

procedure TfrmCadEucColorantes.btnGravarClick(Sender: TObject);
begin
  Try
    fStartTransaction;

    inherited;

    btnRestPreco.Visible := False;

    If blnGravou Then
    Begin
      pAtualizaFatorTintometrico;

      If Not fEmptyStr(strCodIteAnt) Then
      Begin
        if (strCodIteAnt <> dbeIteCol.Text) Then
        begin
          pEnviarLogRep(strCodIteAnt, 'EUC');
        End;
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
end;

procedure TfrmCadEucColorantes.btnAlterarClick(Sender: TObject);
begin
  strCodIteAnt := dbeIteCol.Text;

  inherited;
  If qryTabela.State = dsEdit Then
  Begin
    pSetFocus(dbeCodCol);
    btnRestPreco.Visible := True;
  End;
end;

procedure TfrmCadEucColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeIteCol.Text;
  inherited;

  if fEmptyStr(dbeIteCol.Text) Then
    pEnviarLogRep(strCodIteAnt, 'EUC');

  pCarregaIte;
end;

procedure TfrmCadEucColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaIte;
end;

procedure TfrmCadEucColorantes.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key:= '/';
  if fPesqColorantes(Self, conEUC, nil, nil, qryTabela, Key, arrSel, True, '', '',false) Then
  Begin
    pCarregaIte;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadEucColorantes.pAtualizaFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE ' +
                     ' INNER JOIN EUC_CADCOL ON ITE_CODITE = COL_CODITE ' +
                     '   SET ITE_CNV_ML = IFNULL(COL_EMBALA, 900)';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.

