unit untCfgPontosImpressao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, DB, Grids, DBGridCitel, DBGrids, StdCtrls,
  EditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, UniDataSetProvider,
  UniClientDataSet, Uni, BitBtnLockedIncrem, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, QColorLabel, ComboBoxFocus;

type
  TfrmCfgPontosImpressao = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtPonImp: TEditFocus;
    dbgPonImp: TDBGridCitel;
    btnInserir: TBitBtnLocked;
    dtsPonImp: TDataSource;
    Label2: TLabel;
    edtNomImp: TEditFocus;
    Label3: TLabel;
    edtExpressao: TEditFocus;
    pnlLabel: TPanel;
    Label4: TColorLabel;
    ColorLabel1: TColorLabel;
    Label21: TLabel;
    edtNFeSim: TEditFocus;
    ColorLabel3: TColorLabel;
    btnSelImp: TSpeedButton;
    Label5: TLabel;
    cmbNomMaq: TComboBoxFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgPonImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNFeSimExit(Sender: TObject);
    procedure btnSelImpClick(Sender: TObject);
  private
    cdsPonImp: TUniClientDataSet;

    procedure pCarregaPontos;
    procedure pCarregarNomeMaquinas;
    function  fInserePontosImp(strNomPon, strNomImp, strExpressao, strNFeSim, strNomMaq: String; Var strCodPon: String): Boolean;
    function  fAtualizaPontosImp(strCodPon, strNomPon, strNomImp, strExpressao, strNFeSim, strNomMaq: String): Boolean;
    function  fApagaPontosImp(strCodPon: String): Boolean;
    function  fPontoCadastrado(strNomPon: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples,  untPai, untCfgRel;

{$R *.dfm}

procedure TfrmCfgPontosImpressao.FormShow(Sender: TObject);
begin
  inherited;
  If VS_SpoolImpressaoCitel Then
  Begin
    edtNomImp.ReadOnly    := True;
    edtNomImp.TabStop     := False;
    edtNomImp.Color       := $00FFDFB8;
    edtNomImp.NormalColor := $00FFDFB8;
    edtNomImp.FocusColor  := $00FFDFB8;
    btnSelImp.Visible     := True;
  End;
  pCarregaPontos;
  pCarregarNomeMaquinas;
  pSetFocus(edtPonImp);
end;

procedure TfrmCfgPontosImpressao.pCarregaPontos;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  PON_CODPON AS CODPON, ';
    strSQL := strSQL + '  PON_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  PON_NOMPON AS NOMPON, ';
    strSQL := strSQL + '  PON_NOMIMP AS NOMIMP, ';
    strSQL := strSQL + '  PON_EXPRES AS EXPRES, ';
    strSQL := strSQL + '  PON_NOMMAQ AS NOMMAQ, ';
    strSQL := strSQL + '  PON_NFESIM AS NFESIM  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PONIMP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PON_CODEMP = :CODEMP ';

    If VS_SpoolImpressaoCitel Then
      strSQL := strSQL + '  AND PON_SPOIMP = "S" '
    Else
      strSQL := strSQL + '  AND PON_SPOIMP <> "S" ';

    qryPon := fCriaQuery(Self);

    With qryPon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryPon);
    End;

    cdsPonImp := fCriaClientDatSet(qryPon);
    dtsPonImp.DataSet := cdsPonImp;

    cdsPonImp.FieldByName('NFESIM').Alignment := taCenter;

    FreeAndNil(qryPon);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgPontosImpressao.pCarregaPontos]');
  End
end;

procedure TfrmCfgPontosImpressao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(cdsPonImp);
  inherited;
end;

procedure TfrmCfgPontosImpressao.btnInserirClick(Sender: TObject);
  Var
    strCodPon: String;
begin
  inherited;

  {*********************************************}
  {* VERIFICA PONTO DE IMPRESSÃO JÁ CADASTRADO *}
  {******************************************PZ*}
  If (fPontoCadastrado(edtPonImp.Text)) And edtPonImp.Enabled Then
  Begin
    fMensagem('ATENÇÃO!','Esse Ponto de Impressão já está cadastrado!',['&O k']);
    pSetFocus(edtPonImp);
    Exit;
  End;

  If (Not fEmptyStr(edtPonImp.Text)) And (dbgPonImp.Enabled) Then
  Begin
    With cdsPonImp Do
    Begin
      If fInserePontosImp(edtPonImp.Text, edtNomImp.Text, edtExpressao.Text, edtNFeSim.Text, cmbNomMaq.Text, strCodPon) Then
      Begin
        Append;
        FieldByName('CODPON').AsString := strCodPon;
        FieldByName('CODEMP').AsString := VS_strCodEmp;
        FieldByName('NOMPON').AsString := edtPonImp.Text;
        FieldByName('NOMIMP').AsString := edtNomImp.Text;
        FieldByName('EXPRES').AsString := edtExpressao.Text;
        FieldByName('NFESIM').AsString := edtNFeSim.Text;
        FieldByName('NOMMAQ').AsString := cmbNomMaq.Text;
        Post;
      End;
    End;

    edtPonImp.Clear;
    edtNomImp.Clear;
    edtExpressao.Clear;
    edtNFeSim.Text := 'N';
    cmbNomMaq.ItemIndex := 0;
    pSetFocus(edtPonImp);
  End
  Else If (Not fEmptyStr(edtPonImp.Text)) And (Not dbgPonImp.Enabled) Then
  Begin
    With cdsPonImp Do
    Begin
      If fAtualizaPontosImp(FieldByName('CODPON').AsString, edtPonImp.Text, edtNomImp.Text, edtExpressao.Text, edtNFeSim.Text, cmbNomMaq.Text) Then
      Begin
        Edit;
        FieldByName('NOMPON').AsString := edtPonImp.Text;
        FieldByName('NOMIMP').AsString := edtNomImp.Text;
        FieldByName('EXPRES').AsString := edtExpressao.Text;
        FieldByName('NFESIM').AsString := edtNFeSim.Text;
        FieldByName('NOMMAQ').AsString := cmbNomMaq.Text;
        Post;
      End;
    End;

    edtPonImp.Enabled := True;
    dbgPonImp.Enabled := True;
    edtPonImp.Clear;
    edtNomImp.Clear;
    edtExpressao.Clear;
    edtNFeSim.Text := 'N';
    cmbNomMaq.ItemIndex := 0;
    pSetFocus(edtPonImp);
  End

end;

procedure TfrmCfgPontosImpressao.btnSelImpClick(Sender: TObject);
begin
  inherited;
  edtNomImp.Text := TCfgRel.fSelecionaFila('', '', True, True);
end;

procedure TfrmCfgPontosImpressao.pCarregarNomeMaquinas;
Var
  LQuery: TUniQuery;
begin
  cmbNomMaq.Items.Clear;
  cmbNomMaq.Items.Add(EmptyStr);
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT DISTINCT ');
    LQuery.SQL.Add('  LOG_WTSMAQ AS NOMMAQ ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  LOGACE ');
    LQuery.SQL.Add('WHERE TRUE ');
    LQuery.SQL.Add('  AND LOG_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) ');
    LQuery.SQL.Add('  AND LOG_WTSMAQ <> "" ');
    LQuery.SQL.Add('ORDER BY NOMMAQ ');
    LQuery.Open;
    While Not LQuery.Eof Do
    Begin
      cmbNomMaq.Items.Add(LQuery.FieldByName('NOMMAQ').AsString);
      LQuery.Next;
    End;
  Finally
    LQuery.Free;
  End;
end;


procedure TfrmCfgPontosImpressao.dbgPonImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  {**********************************}
  {* MARCA O REGISTRO PARA EXCLUSÃO *}
  {*******************************PZ*}
  If (Key = VK_DELETE) And (Not cdsPonImp.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o Ponto de Impressão ' + cdsPonImp.FieldByName('NOMPON').AsString, ['&Sim','&Não'], 2) = 1) Then
    Begin
      If fApagaPontosImp(cdsPonImp.FieldByName('CODPON').AsString) Then
        cdsPonImp.Delete;
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsPonImp.IsEmpty) Then
  Begin
    edtPonImp.Text    := cdsPonImp.FieldByName('NOMPON').AsString;
    edtNomImp.Text    := cdsPonImp.FieldByName('NOMIMP').AsString;
    edtExpressao.Text := cdsPonImp.FieldByName('EXPRES').AsString;
    edtNFeSim.Text    := cdsPonImp.FieldByName('NFESIM').AsString;
    cmbNomMaq.ItemIndex := cmbNomMaq.Items.IndexOf(cdsPonImp.FieldByName('NOMMAQ').AsString);

    edtPonImp.Enabled := False;
    dbgPonImp.Enabled := False;
    dbgPonImp.Repaint;
    pSetFocus(edtNomImp);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtPonImp.Clear;
    edtNomImp.Clear;
    edtExpressao.Clear;
    edtNFeSim.Text := 'N';
    cmbNomMaq.ItemIndex := 0;
    pSetFocus(edtPonImp);
  End;

end;

procedure TfrmCfgPontosImpressao.edtNFeSimExit(Sender: TObject);
begin
  inherited;
  If (edtNFeSim.Text <> 'S') And (edtNFeSim.Text <> 'N') Then
    edtNFeSim.Text := 'N';
end;

function TfrmCfgPontosImpressao.fApagaPontosImp(strCodPon: String): Boolean;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Result := False;

  Try

    qryPon := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  PONIMP    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  PON_CODPON = :CODPON ';

    With qryPon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPON').AsString := strCodPon;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgPontosImpressao.fApagaPontosImp]');
  End;

  FreeAndNil(qryPon);

end;

function TfrmCfgPontosImpressao.fAtualizaPontosImp(strCodPon, strNomPon, strNomImp, strExpressao, strNFeSim, strNomMaq: String): Boolean;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Result := False;

  Try

    qryPon := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  PONIMP ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  PON_NOMPON = :NOMPON, ';
    strSQL := strSQL + '  PON_NOMIMP = :NOMIMP, ';
    strSQL := strSQL + '  PON_EXPRES = :EXPRES, ';
    strSQL := strSQL + '  PON_NFESIM = :NFESIM, ';
    strSQL := strSQL + '  PON_NOMMAQ = :NOMMAQ  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PON_CODPON = :CODPON ';

    With qryPon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMPON').AsString := strNomPon;
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('EXPRES').AsString := strExpressao;
      ParamByName('NFESIM').AsString := strNFeSim;
      ParamByName('NOMMAQ').AsString := strNomMaq;
      ParamByName('CODPON').AsString := strCodPon;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgPontosImpressao.fAtualizaPontosImp]');
  End;

  FreeAndNil(qryPon);

end;

function TfrmCfgPontosImpressao.fInserePontosImp(strNomPon, strNomImp, strExpressao, strNFeSim, strNomMaq: String; Var strCodPon: String): Boolean;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Result := False;

  Try

    qryPon := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  PONIMP(             ';
    strSQL := strSQL + '         PON_CODPON,  ';
    strSQL := strSQL + '         PON_NOMPON,  ';
    strSQL := strSQL + '         PON_NOMIMP,  ';
    strSQL := strSQL + '         PON_EXPRES,  ';
    strSQL := strSQL + '         PON_NFESIM,  ';
    strSQL := strSQL + '         PON_NOMMAQ,  ';
    strSQL := strSQL + '         PON_CODEMP,  ';
    strSQL := strSQL + '         PON_SPOIMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODPON,     ';
    strSQL := strSQL + '         :NOMPON,     ';
    strSQL := strSQL + '         :NOMIMP,     ';
    strSQL := strSQL + '         :EXPRES,     ';
    strSQL := strSQL + '         :NFESIM,     ';
    strSQL := strSQL + '         :NOMMAQ,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :SPOIMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryPon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      strCodPon := fAtualizaProCod('PONIMP', 'PON_CODPON');
      ParamByName('CODPON').AsString := strCodPon;
      ParamByName('NOMPON').AsString := strNomPon;
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('EXPRES').AsString := strExpressao;
      ParamByName('NFESIM').AsString := strNFeSim;
      ParamByName('NOMMAQ').AsString := strNomMaq;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('PONIMP', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgPontosImpressao.fInserePontosImp]');
  End;

  FreeAndNil(qryPon);

end;

function TfrmCfgPontosImpressao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtPonImp) Then
  Begin
    If (fEmptyStr(edtPonImp.Text)) And (dbgPonImp.CanFocus) Then
    Begin
      pSetFocus(dbgPonImp);
      blnMudarFoco := False;
    End;
  End;

  If (Sender = edtNFeSim) Then
  Begin
    If (edtNFeSim.Text <> 'S') And (edtNFeSim.Text <> 'N') Then
    Begin
      pMensagemOk('O campo "DANFE - Simplificada" deve ser "S" ou "N" !');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;


function TfrmCfgPontosImpressao.fPontoCadastrado(
  strNomPon: String): Boolean;
Var
  cdsPonTmp: TUniClientDataSet;
begin

  cdsPonTmp := TUniClientDataSet.Create(Self);
  cdsPonTmp.Data := cdsPonImp.Data;

  Result := False;

  With cdsPonTmp Do
  Begin
    First;

    While Not Eof Do
    Begin
      If (FieldByName('NOMPON').AsString = strNomPon) Then
        Result := True;

      Next;
    End;

  End;

end;

end.
