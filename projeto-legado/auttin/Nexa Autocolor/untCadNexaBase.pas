unit untCadNexaBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;


type
  TfrmCadNexaBase = class(TfrmPaiCad)
    pnlFundo: TPanel;
    btnRestPreco: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    dbeCodBas: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeDesBas: TDBEditFocus;
    dbePesEsp: TDBEditFocus;
    dbeTipo: TDBEditFocus;
    dbePCusto: TDBEditFocus;
    dbePMargem: TDBEditFocus;
    dbeEmbalagem: TDBEditFocus;
    dbePVenda: TDBEditFocus;
    edtDesIte: TEditFocus;
    dbeBasePo: TDBCheckBox;
    btnBasEmp: TBitBtnLocked;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeBasePoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBasEmpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    arrOpcoesTipo: Array[1..7] of String;
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    StrCodIteAnt : String;

    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaIte;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pHabilitaBtn;
    procedure pHabilitaBtnBasEmp;
    procedure pBasesPorEmpresas;
  public
    { Public declarations }
  protected
    procedure pUpdateFatorTintometrico;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmCadNexaBase: TfrmCadNexaBase;

implementation

uses untFuncoesSimples, untFuncTinta,
      untIConfTinta, untCadNexaBasesEmp, untTypesSistema, untConsultas,
  untValidarBaseItemAmarracao;

{$R *.dfm}

procedure TfrmCadNexaBase.FormCreate(Sender: TObject);
begin
  inherited;
  
  arrOpcoesTipo[1] := '2K';
  arrOpcoesTipo[2] := 'ACS (LA)';
  arrOpcoesTipo[3] := 'INDUSTRAN';
  arrOpcoesTipo[4] := 'SPECTRAL GREY';
  arrOpcoesTipo[5] := 'ZYNAMIX';
  arrOpcoesTipo[6] := 'ACS EVOLUTION (LA)';
  arrOpcoesTipo[7] := 'TURBO PLUS';

  pCriaDataSets;
  pLigaDataSets;

  qryTabela     := qryCadBas;
  strNomeTabela := 'NEX_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBas;
end;

procedure TfrmCadNexaBase.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadNexaBase.dbeTipoKeyPress(Sender: TObject; var Key: Char);
  Var
    intOpcao: Integer;

begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    intOpcao := fGetMenu('Tipo de Bases', arrOpcoesTipo, 1, True);
    If intOpcao > 0 Then
      dbeTipo.Field.AsString := arrOpcoesTipo[intOpcao];
  End;

end;

function TfrmCadNexaBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodBas Then
    Begin
      If fEmptyStr(dbeCodBas.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Código da base deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesBas Then
    Begin
      If fEmptyStr(dbeDesBas.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Descrição da base dese ver preencida!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbePesEsp Then
    Begin

      If  fEmptyStr(dbePesEsp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O peso especifico deve ser preenchido!', ['OK']);
        Result := False ;
      End;

    End
    Else If Sender = dbeEmbalagem Then
    Begin
      If fEmptyStr(dbeEmbalagem.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(dbeEmbalagem.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A Embalagem deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbeTipo Then
    Begin

      If  fEmptyStr(dbeTipo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O tipo deve ser preenchido!', ['OK']);
        Result := False;
      End;

    End

    Else If Sender = dbeCodIte Then
    Begin

      pCarregaIte;
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está Cadastrado!', ['OK']);
          Result := False;
        End

        Else If Not (fItemAtivo(dbeCodIte.Field.AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está ativo!', ['OK']);
          Result := False;
        End;
      End;

    End
    Else If Not fEmptyStr(dbecodIte.Field.AsString) Then
    Begin

      If Sender = dbePCusto Then
      Begin

        If fEmptyStr(dbePCusto.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de custo deve ser preenchido!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePCusto.Text) <= 0Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de custo deve ser maior que zero', ['OK']);
          Result := False;
        End
        Else
          dbePVenda.Field.AsFloat := fRetPrecoVenda(1);
      End
      Else If Sender = dbePVenda Then
      Begin
        If fEmptyStr(dbePVenda.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de venda deve ser preenchido!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePVenda.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de venda deve ser maior que zero!', ['OK']);
          Result := False;
        End
        Else
          dbePMargem.Field.AsFloat := fRetPrecoVenda(2);
      End
      Else If Sender = dbePMargem Then
      Begin
        If fEmptyStr(dbePMargem.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'A Margem deve ser preenchida!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePMargem.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A Margem deve ser maior que zero!', ['OK']);
          Result := False;
        End
        Else
          dbePVenda.Field.AsFloat := fRetPrecoVenda(1);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadNexaBase.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('BAS_CODBAS+BAS_DESBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código/Descrição');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência');
end;

procedure TfrmCadNexaBase.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadBas := fCriarQuery('SELECT * FROM NEX_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_CODITE').DisplayLabel := 'Código Item';
  qryCadBas.FieldByName('BAS_DESBAS').DisplayLabel := 'Descrição';
  qryCadBas.FieldByName('BAS_PESESP').DisplayLabel := 'Peso Especifico';
  qryCadBas.FieldByName('BAS_EMBALA').DisplayLabel := 'Embalagem';
  qryCadBas.FieldByName('BAS_TIPO__').DisplayLabel := 'Tipo';
  qryCadBas.FieldByName('BAS_PRECUS').DisplayLabel := 'Preço de custo';
  qryCadBas.FieldByName('BAS_MARGEM').DisplayLabel := 'Margem';
  qryCadBas.FieldByName('BAS_PREVEN').DisplayLabel := 'Preço de Venda';

  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.0000';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadNexaBase.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadNexaBase.pHabilitaBtnBasEmp;
begin
  btnBasEmp.Enabled := (Not (qryTabela.IsEmpty)) And (Not (qryTabela.State in [dsEdit, dsInsert]));
end;

procedure TfrmCadNexaBase.pLigaDataSets;
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
    End
    Else If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadBas;
    End;
  End;

  {**************************************}
  {* LIGA OS DBEDITS NOS DEVIDOS CAMPOS *}
  {***********************************PH*}
  dbeCodBas.DataField := 'BAS_CODBAS';
  dbeCodIte.DataField := 'BAS_CODITE';
  dbeDesBas.DataField := 'BAS_DESBAS';
  dbePesEsp.DataField := 'BAS_PESESP';
  dbeEmbalagem.DataField := 'BAS_EMBALA';
  dbeTipo.DataField := 'BAS_TIPO__';
  dbeBasePo.DataField := 'BAS_BASEPO';
  dbePCusto.DataField := 'BAS_PRECUS';
  dbePMargem.DataField := 'BAS_MARGEM';
  dbePVenda.DataField := 'BAS_PREVEN';


end;

procedure TfrmCadNexaBase.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadNexaBase.pBasesPorEmpresas;
begin
  Try
    Try
      frmCadNexaBasesEmp := TfrmCadNexaBasesEmp.Create(Self);
      frmCadNexaBasesEmp.strCodBas := qryTabela.FieldByName('BAS_CODBAS').AsString;
      frmCadNexaBasesEmp.strDesBas := qryTabela.FieldByName('BAS_DESBAS').AsString;
      frmCadNexaBasesEmp.strBasEpo := qryTabela.FieldByName('BAS_BASEPO').AsString;
      frmCadNexaBasesEmp.fltPesEsp := qryTabela.FieldByName('BAS_PESESP').AsFloat;
      frmCadNexaBasesEmp.fltEmbala := qryTabela.FieldByName('BAS_EMBALA').AsFloat;
      frmCadNexaBasesEmp.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmCadNexaBasesEmp) then pFreeAndNil(frmCadNexaBasesEmp);
  End;
end;

procedure TfrmCadNexaBase.pCarregaIte;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
  qryGen.Open;

  edtDesIte.Text := qryGen.FieldbyName('ITE_DESITE').AsString;
end;

procedure TfrmCadNexaBase.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Field.AsString, fltPrecus, fltMargem, fltPreVen);
  dbePCusto.Field.AsFloat := fltPrecus;
  dbePMargem.Field.AsFloat := fltMargem;
  dbePVenda.Field.AsFloat := fltPreVen;
end;

function TfrmCadNexaBase.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePVenda.Field.AsString) Then
    dbePVenda.Field.AsString := '0,00';

  If fEmptyStr(dbePMargem.Field.AsString) Then
    dbePMargem.Field.AsString := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePCusto.Text),
                               fStrToFloat(dbePVenda.Text),
                               fStrToFloat(dbePMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

procedure TfrmCadNexaBase.btnBasEmpClick(Sender: TObject);
begin
  inherited;
  If Not qryTabela.IsEmpty Then
    pBasesPorEmpresas;
end;

procedure TfrmCadNexaBase.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtnBasEmp;
  pCarregaIte;
end;

procedure TfrmCadNexaBase.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodite.Text;
  inherited;

  If fEmptyStr(dbeCodite.Text) Then
    pEnviarLogRep(strCodIteAnt, 'NEX');

  pHabilitaBtnBasEmp;
  edtDesIte.Clear;
end;

procedure TfrmCadNexaBase.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (dtsCadBas.DataSet.State in [dsEdit]);

  Try
    fStartTransaction;

    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('NEX', dbeCodBas.text, dbeDesBas.text, dbeCodIte.Text , StrCodIteAnt ,
                                                             dtsCadBas.DataSet.FieldByName('BAS_PESESP').AsFloat , strToFloat(dbeEmbalagem.Text)) Then
    begin
      inherited;
      pUpdateFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'NEX');
      End;

      pHabilitaBtnBasEmp;
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

procedure TfrmCadNexaBase.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  strCoditeAnt := '';

  pSetFocus(dbeCodBas);

  qryCadBas.FieldByName('BAS_BASEPO').AsString := 'N';

  edtDesIte.Clear;

  pHabilitaBtn;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadNexaBase.dbeBasePoClick(Sender: TObject);
begin
  inherited;
  If (dbeBasePo.Checked) Then
  Begin
    dbePesEsp.Enabled := False;
    dbePesEsp.Hint := 'Base em pó não necessita de peso específico.';
    dbePesEsp.ShowHint := True;
  End
  Else
  Begin
    dbePesEsp.Enabled := True;
    dbePesEsp.Hint := '';
    dbePesEsp.ShowHint := False;  
  End;
end;

procedure TfrmCadNexaBase.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaIte;
end;

procedure TfrmCadNexaBase.btnPesquisaClick(Sender: TObject);
  Var
   arrSel: TConsultasArray;
   Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conNex, Nil, Nil, qryTabela, Key, ArrSel, True, '', '', False) Then
  Begin
    pCarregaIte;
    pHabilitaBtnBasEmp;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadNexaBase.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;
  pSetFocus(dbeDesBas);
  dbePesEsp.ReadOnly := True;
  pHabilitaBtn;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadNexaBase.pUpdateFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE '+
                     ' INNER JOIN NEX_CADBAS '+
                     '         ON ITE_CODITE = BAS_CODITE '+
                     '   SET ITE_CNV_ML = BAS_EMBALA * IF(BAS_BASEPO="S", 1, BAS_PESESP);';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadNexaBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pUpdateFatorTintometrico;
end;

end.
