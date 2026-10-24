unit untCadAdtColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAdtColorantes = class(TfrmPaiCad)
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
    strCodIteAnt : String;
    procedure pCriaDataSets;
    procedure pLigaDataSets;

    procedure pbtnRestaura;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pHabilitaBtn;
    procedure AtualizarCnvMl;

    procedure pAddMascara;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadAdtColorantes: TfrmCadAdtColorantes;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAdtColorantes }

function TfrmCadAdtColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    pCarregaItem;
    
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
        dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End
      
      Else If Sender = dbePreVen Then
      Begin
        dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End

      Else If Sender = dbeMargem Then
      Begin
        dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdtColorantes.pInicializaIndices;
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

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Descrição do Colorante');
end;

procedure TfrmCadAdtColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'ADT_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadAdtColorantes.pCriaDataSets;
begin

  qryCadCol := fCriarQuery('SELECT * FROM ADT_CADCOL', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Código';
  qryCadCol.FieldbyName('COL_DESCRI').DisplayLabel := 'Descrição';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;

  pAddMascara;

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadAdtColorantes.pLigaDataSets;
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

procedure TfrmCadAdtColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadAdtColorantes.pAddMascara;
begin
  TFloatField(qryCadCol.FieldByName('COL_PRECUS')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_PREVEN')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_MARGEM')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_PESESP')).DisplayFormat := '0.0000';
  TFloatField(qryCadCol.FieldByName('COL_EMBALA')).DisplayFormat := '0.0000';
end;

procedure TfrmCadAdtColorantes.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadCol.State = dsEdit;
end;

procedure TfrmCadAdtColorantes.btnGravarClick(Sender: TObject);
begin
  fStartTransaction;
  inherited;

  Try
    pbtnRestaura;

    If blnGravou Then
    begin
      AtualizarCnvMl;

      If Not fEmptyStr(strCodIteAnt) Then
      Begin
        if (strCodIteAnt <> dbeCodIte.Text) Then
        begin
          pEnviarLogRep(strCodIteAnt, 'ADT');
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

procedure TfrmCadAdtColorantes.AtualizarCnvMl;
begin
  fExecutaSQL(
    ' UPDATE                                     ' +
    '   CADITE                                   ' +
    '   INNER JOIN ADT_CADCOL                    ' +
    '     ON ITE_CODITE = COL_CODITE             ' +
    ' SET ITE_CNV_ML = (COL_PESESP * COL_EMBALA) ');
end;

procedure TfrmCadAdtColorantes.btnAlterarClick(Sender: TObject);
begin
  pAddMascara;
  strCodIteAnt := dbeCodIte.Text;

  inherited;
  pSetFocus(dbeCodigo);
  pbtnRestaura;
  pHabilitaBtn;
end;

procedure TfrmCadAdtColorantes.btnCancelaClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;
  edtDesIte.Text := fGetDescricaoProdutoTinta(dbeCodIte.Text);
  pbtnRestaura;
end;

procedure TfrmCadAdtColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  If fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'ADT');

  edtDesIte.Clear;
  pbtnRestaura;
end;

procedure TfrmCadAdtColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
  Begin
    pCarregaItem;
    btnRestPreco.Click;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAdtColorantes.pCarregaItem;
begin
  edtDesIte.Text := fGetDescricaoProdutoTinta(dbeCodIte.Text);
end;

function TfrmCadAdtColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadAdtColorantes.btnIncluirClick(Sender: TObject);
begin
  pAddMascara;
  inherited;
  blnUsaProCodigo := False;

  strCodIteAnt    := '';

  pSetFocus(dbeCodigo);
  edtDesIte.Clear;
  pHabilitaBtn;  
end;

procedure TfrmCadAdtColorantes.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conAdt, Nil, Nil, qryTabela, Key, arrSel, True, '','',False) Then
  Begin
    TFloatField(qryTabela.FieldByName('COL_EMBALA')).DisplayFormat := '0.000';
    pCarregaItem;

    pSetFocus(btnAlterar);
  End;
  pAddMascara;
end;

procedure TfrmCadAdtColorantes.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;


end.

