unit untCadAdvColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAdvColorantes = class(TfrmPaiCad)
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
    dbePesEsp: TDBEditFocus;
    lblEmbalagem: TLabel;
    dbeEmbalagem: TDBEditFocus;
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
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pbtnRestaura;
    procedure pCarregaItem;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pAjustaFatorTintometrico;
    procedure pHabilitaBtn;
    procedure pAddMascara;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadAdvColorantes: TfrmCadAdvColorantes;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAdvColorantes }

function TfrmCadAdvColorantes.fValidaCampos(Sender: TWinControl;
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
    else if Sender = dbeEmbalagem then
    begin
      if fStrToFloat(dbeEmbalagem.Text) <= 0 then
      begin
        Result := False;
        fMensagem('ATENÇÃO', 'A embalagem deve ser maior que zero!', ['OK']);
      end;  
    end
    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
        Result := fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']) = -1;
    End

    Else If Sender = dbePesEsp Then
    Begin
      If fEmptyStr(dbePesEsp.Text) Then
        Result := fMensagem('ATENÇÃO', 'O peso específico deve ser preenchido!', ['OK']) = -1
      Else If fStrToFloat(dbePesEsp.Text) <= 0 Then
        Result := fMensagem('ATENÇÃO', 'O peso específico deve ser maior que zero!', ['OK']) = -1;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      pCarregaItem;

      If Sender = dbeCodIte Then
      Begin
        If fEmptyStr(edtDesIte.Text) Then
          Result := fMensagem('ATENÇÃO', Format('O produto %s não está cadastrado', [dbeCodIte.Text]), ['&OK']) = -1
        Else If Not fItemAtivo(dbeCodIte.Text) Then
          Result := fMensagem('ATENÇÃO', 'O item não está ativo!', ['OK']) = -1
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'ADV_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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

procedure TfrmCadAdvColorantes.pInicializaIndices;
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

procedure TfrmCadAdvColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'ADV_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadAdvColorantes.pCriaDataSets;
begin

  qryCadCol := fCriarQuery('SELECT * FROM ADV_CADCOL', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Código';
  qryCadCol.FieldbyName('COL_DESCRI').DisplayLabel := 'Descrição';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;

  pAddMascara;

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadAdvColorantes.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

Procedure TfrmCadAdvColorantes.pAddMascara;
begin
  TFloatField(qryCadCol.FieldByName('COL_PRECUS')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_PREVEN')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_MARGEM')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_PESESP')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_EMBALA')).DisplayFormat := '0.0000';
end;

procedure TfrmCadAdvColorantes.pLigaDataSets;
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

procedure TfrmCadAdvColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadAdvColorantes.pAjustaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                                                              ' +
    '   CADITE                                                            ' +
    '   INNER JOIN ADV_CADCOL                                             ' +
    '     ON ITE_CODITE = COL_CODITE                                      ' +
    ' SET ITE_CNV_ML = (IFNULL(COL_PESESP, 1) * IFNULL(COL_EMBALA, 3600)) ');
end;

procedure TfrmCadAdvColorantes.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadCol.State = dsEdit;
end;

procedure TfrmCadAdvColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pAjustaFatorTintometrico;
end;

procedure TfrmCadAdvColorantes.btnAlterarClick(Sender: TObject);
begin
  pAddMascara;
  inherited;
  pSetFocus(dbeCodigo);
  pbtnRestaura;
  pHabilitaBtn;
end;

procedure TfrmCadAdvColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdvColorantes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdvColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAdvColorantes.pCarregaItem;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
      qryGen.ParamByName('CODITE').AsString := dbeCodIte.Text;
      qryGen.Open;
      edtDesIte.Text := qryGen.FieldByName('ITE_DESITE').AsString;
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

function TfrmCadAdvColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadAdvColorantes.btnIncluirClick(Sender: TObject);
begin
  pAddMascara;
  inherited;

  blnUsaProCodigo := False;
  pSetFocus(dbeCodigo);
  pHabilitaBtn;
end;

procedure TfrmCadAdvColorantes.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conAdv, nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
    pSetFocus(btnAlterar);
  pAddMascara;

end;

end.

