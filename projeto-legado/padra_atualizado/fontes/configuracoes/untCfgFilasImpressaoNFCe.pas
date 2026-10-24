unit untCfgFilasImpressaoNFCe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, DB, Grids, DBGrids, StdCtrls, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Provider, DBClient, Uni,
  BitBtnLockedIncrem,  QColorLabel, ComboBoxFocus, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet, DBGridCitel, UniDataSetProvider;

type
  TfrmCfgFilasImpressaoNFCe = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtNomImp: TEditFocus;
    dbgFilImp: TDBGridCitel;
    dtsFilImp: TDataSource;
    cdsFilImp: TUniClientDataSet;
    btnInserir: TBitBtnLocked;
    dspFilImp: TUniDataSetProvider;
    Label2: TLabel;
    edtDescri: TEditFocus;
    btnSelImp: TSpeedButton;
    Label5: TLabel;
    cmbNomMaq: TComboBoxFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgFilImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbgFilImpDblClick(Sender: TObject);
    procedure btnSelImpClick(Sender: TObject);
  private
    qryFilas: TUniQuery;
    strRegAtu: String;

    procedure pCarregaFilas;
    function  fInsereFilasImp(strNomImp, strDescri: String; Var strCodFil: String): Boolean;
    function  fAtualizaFilasImp(strCodFil, strNomImp, strDescri: String): Boolean;
    function  fApagaFilasImp(strCodFil: String): Boolean;
    procedure pCarregarNomeMaquinas;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    strFilaImpressao: String;
  end;

implementation

uses untFuncoesSimples, untConsultas, untPai, untMemo, untTypesSistema, untFuncFatImp,
  untCfgRel;

{$R *.dfm}

procedure TfrmCfgFilasImpressaoNFCe.FormShow(Sender: TObject);
begin
  inherited;
  qryFilas := fCriaQuery(Self);
  dspFilImp.DataSet := qryFilas;
  cdsFilImp.SetProvider(dspFilImp);
  dtsFilImp.DataSet := cdsFilImp;

  pCarregaFilas;
  pCarregarNomeMaquinas;
  strRegAtu := '';

  If VS_SpoolImpressaoCitel Then
  Begin
    edtNomImp.ReadOnly    := True;
    edtNomImp.TabStop     := False;
    edtNomImp.Color       := $00FFDFB8;
    edtNomImp.NormalColor := $00FFDFB8;
    edtNomImp.FocusColor  := $00FFDFB8;
    btnSelImp.Visible     := True;
  End;
end;

procedure TfrmCfgFilasImpressaoNFCe.pCarregaFilas;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  FIL_CODFIL, ';
    strSQL := strSQL + '  FIL_CODEMP, ';
    strSQL := strSQL + '  FIL_NOMIMP, ';
    strSQL := strSQL + '  FIL_DESCRI, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  FIL_NOMMAQ  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  FILNFC ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';

    If VS_SpoolImpressaoCitel Then
      strSQL := strSQL + '  AND FIL_SPOIMP = "S" '
    Else
      strSQL := strSQL + '  AND FIL_SPOIMP <> "S" ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryFilas);
    End;

    cdsFilImp.Close;
    cdsFilImp.Open;
    pSetaClient(cdsFilImp);

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoNFCe.pCarregaFilas]');
  End
end;

procedure TfrmCfgFilasImpressaoNFCe.pEscapePressed;
begin
  If Not dbgFilImp.Enabled Then
  Begin
    dbgFilImp.Enabled := True;
    edtNomImp.Clear;
    edtDescri.Clear;
    cmbNomMaq.ItemIndex := 0;
    pSetFocus(edtDescri);
  End
  Else
    inherited;
end;

procedure TfrmCfgFilasImpressaoNFCe.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescri);
end;

procedure TfrmCfgFilasImpressaoNFCe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryFilas);
  
  inherited;
end;

procedure TfrmCfgFilasImpressaoNFCe.btnInserirClick(Sender: TObject);
  var
    strCodFilIns: String;
begin
  inherited;

  strCodFilIns := '';

  If fVerificaCampos Then
  Begin

    If (dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Append;
        FieldByName('FIL_CODEMP').AsString := VS_strCodEmp;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_NOMMAQ').AsString := cmbNomMaq.Text;
        Post;

        If fInsereFilasImp(edtNomImp.Text, edtDescri.Text, strCodFilIns) Then
        Begin
          Edit;
          FieldByName('FIL_CODFIL').AsString := strCodFilIns;
          Post;
        End;
      End;

      edtNomImp.Clear;
      edtDescri.Clear;
      cmbNomMaq.ItemIndex := 0;
      pSetFocus(edtDescri);
    End
    Else If (Not dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Edit;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_NOMMAQ').AsString := cmbNomMaq.Text;
        Post;

        fAtualizaFilasImp(FieldByName('FIL_CODFIL').AsString, edtNomImp.Text, edtDescri.Text);

        strRegAtu := '';
      End;

      dbgFilImp.Enabled := True;

      edtNomImp.Clear;
      edtDescri.Clear;
      cmbNomMaq.ItemIndex := 0;

      pSetFocus(edtDescri);
    End;

  End;

end;

procedure TfrmCfgFilasImpressaoNFCe.btnSelImpClick(Sender: TObject);
begin
  inherited;
  edtNomImp.Text := TCfgRel.fSelecionaFila('', '', True, True);
end;

procedure TfrmCfgFilasImpressaoNFCe.dbgFilImpDblClick(Sender: TObject);
  Var
    Key: Word;
begin
  inherited;
  Key := VK_RETURN;
  dbgFilImpKeyDown(Sender, Key, []);
end;

procedure TfrmCfgFilasImpressaoNFCe.dbgFilImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strCodFil: String;
begin
  inherited;

  strCodFil := '';

  {**********************************}
  {* MARCA O REGISTRO PARA EXCLUSÃO *}
  {*******************************PZ*}
  If (Key = VK_DELETE) And (Not cdsFilImp.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir a Fila de Impressão "' +
      cdsFilImp.FieldByName('FIL_DESCRI').AsString + '" ?', ['&Sim','&Não'], 2) = 1) Then
    Begin
      strCodFil := cdsFilImp.FieldByName('FIL_CODFIL').AsString;

      cdsFilImp.Delete;

      fApagaFilasImp(strCodFil);
    End;
  End
  Else If (Key = VK_RETURN) And (Not cdsFilImp.IsEmpty) Then
  Begin
    edtNomImp.Text    := cdsFilImp.FieldByName('FIL_NOMIMP').AsString;
    edtDescri.Text    := cdsFilImp.FieldByName('FIL_DESCRI').AsString;
    cmbNomMaq.ItemIndex := cmbNomMaq.Items.IndexOf(cdsFilImp.FieldByName('FIL_NOMMAQ').AsString);
    dbgFilImp.Enabled := False;
    dbgFilImp.Repaint;
    pSetFocus(edtDescri);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomImp.Clear;
    edtDescri.Clear;
    cmbNomMaq.ItemIndex := 0;
    pSetFocus(edtDescri);
  End;

end;

function TfrmCfgFilasImpressaoNFCe.fApagaFilasImp(
  strCodFil: String): Boolean;
Var
  strSQL: String;
  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  FILNFC    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  FIL_CODFIL = :CODFIL AND ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoNFCe.fApagaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoNFCe.fAtualizaFilasImp(strCodFil, strNomImp, strDescri: String): Boolean;
Var
  strSQL: String;
  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  FILNFC ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  FIL_NOMIMP = :NOMIMP, ';
    strSQL := strSQL + '  FIL_DESCRI = :DESCRI, ';
    strSQL := strSQL + '  FIL_NOMMAQ = :NOMMAQ  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FIL_CODFIL = :CODFIL AND ';
    strSQL := strSQL + '  FIL_CODEMP = :CODEMP ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('NOMMAQ').AsString := cmbNomMaq.Text;;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoNFCe.fAtualizaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoNFCe.fInsereFilasImp(strNomImp, strDescri: String; Var strCodFil: String): Boolean;
Var
  strSQL: String;

  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  FILNFC(             ';
    strSQL := strSQL + '         FIL_CODFIL,  ';
    strSQL := strSQL + '         FIL_CODEMP,  ';
    strSQL := strSQL + '         FIL_NOMIMP,  ';
    strSQL := strSQL + '         FIL_DESCRI,  ';
    strSQL := strSQL + '         FIL_SPOIMP,  ';
    strSQL := strSQL + '         FIL_NOMMAQ,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODFIL,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :NOMIMP,     ';
    strSQL := strSQL + '         :DESCRI,     ';
    strSQL := strSQL + '         :SPOIMP,     ';
    strSQL := strSQL + '         :NOMMAQ,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      strCodFil := fAtualizaProCod('FILNFC', 'FIL_CODFIL');

      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('FILNFC', VS_strCodEmp);
      ParamByName('NOMMAQ').AsString := cmbNomMaq.Text;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoNFCe.fInsereFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoNFCe.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtDescri) Then
  Begin
    If (fEmptyStr(edtDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A descrição deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgFilasImpressaoNFCe.pCarregarNomeMaquinas;
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

end.
