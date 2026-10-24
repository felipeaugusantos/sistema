unit untCadKilColorantesDin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadKilColorantesDin = class(TfrmPaiCad)
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
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    qryCadCol: TUniQuery;
    dtsCadCol: TDataSource;
    strCodIteAnt : String;

    procedure pCriaDataSets;
    procedure pLigaDataSets;

    procedure pbtnRestaura;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pAtualizaFatorTintometrico;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadKilColorantesDin: TfrmCadKilColorantesDin;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadKilColorantesDin }

function TfrmCadKilColorantesDin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
        Result := fMensagem('ATENÇÃO', 'O código do colorante deve ser preenchido!', ['OK']) = -1;
    End

    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
        Result := fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']) = -1;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      pCarregaItem;

      If Sender = dbeCodIte Then
      Begin
        If fEmptyStr(edtDesIte.Text) Then
          Result := fMensagem('ATENÇÃO', 'O item não está cadastrado!', ['OK']) = -1
        Else If Not fItemAtivo(dbeCodIte.Text) Then
          Result := fMensagem('ATENÇÃO', 'O item não está ativo!', ['OK']) = -1
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'KILD_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado com outro colorante!'#10#13'Deseja Continuar?', ['Sim', 'Não']) = 1;
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

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadKilColorantesDin.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('COL_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadKilColorantesDin.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'KILD_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadKilColorantesDin.pCriaDataSets;
begin

  qryCadCol := fCriarQuery('SELECT * FROM KILD_CADCOL', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Código';
  qryCadCol.FieldbyName('COL_DESCRI').DisplayLabel := 'Descrição';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadCol.FieldByName('COL_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadCol.FieldByName('COL_MARGEM')).DisplayFormat := '0.00';  

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadKilColorantesDin.pLigaDataSets;
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
end;

procedure TfrmCadKilColorantesDin.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadKilColorantesDin.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                         ' +
        '   CADITE                       ' +
        '   INNER JOIN KILD_CADCOL       ' +
        '     ON COL_CODITE = ITE_CODITE ' +
        ' SET ITE_CNV_ML = 1000           ';
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

procedure TfrmCadKilColorantesDin.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadCol.State = dsEdit;
end;

procedure TfrmCadKilColorantesDin.btnGravarClick(Sender: TObject);
begin
  Try
    fStartTransaction;
    inherited;
    pbtnRestaura;

    If blnGravou Then
    Begin
      pAtualizaFatorTintometrico;

      If Not fEmptyStr(strCoditeAnt) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'KILD');
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

procedure TfrmCadKilColorantesDin.btnAlterarClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;
  pSetFocus(dbeCodigo);
  pbtnRestaura;
end;

procedure TfrmCadKilColorantesDin.btnCancelaClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  If fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'KILD');

  pbtnRestaura;
  pCarregaItem;
end;

procedure TfrmCadKilColorantesDin.btnExcluirClick(Sender: TObject);
begin
  inherited;
  edtDesIte.Clear;
  pbtnRestaura;
end;

procedure TfrmCadKilColorantesDin.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadKilColorantesDin.pCarregaItem;
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

function TfrmCadKilColorantesDin.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadKilColorantesDin.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  blnUsaProCodigo := False;
  edtDesIte.Clear;
  
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadKilColorantesDin.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conKild, nil, nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

end.

