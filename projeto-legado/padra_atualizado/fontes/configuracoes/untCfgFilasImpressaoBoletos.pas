unit untCfgFilasImpressaoBoletos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, DB, Grids, DBGrids, StdCtrls, EditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Provider, DBClient, Uni,
  BitBtnLockedIncrem,  QColorLabel, ComboBoxFocus, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet, DBGridCitel, UniDataSetProvider;

type
  TfrmCfgFilasImpressaoBoletos = class(TfrmPaiSimples)
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
    memWhere: TMemo;
    Label3: TLabel;
    spbShowSQL: TSpeedButton;
    btnSelImp: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgFilImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure memWhereKeyPress(Sender: TObject; var Key: Char);
    procedure memWhereEnter(Sender: TObject);
    procedure spbShowSQLClick(Sender: TObject);
    procedure dbgFilImpDblClick(Sender: TObject);
    procedure btnSelImpClick(Sender: TObject);
  private
    qryFilas: TUniQuery;
    strRegAtu: String;

    procedure pCarregaFilas;
    function  fInsereFilasImp(strNomImp, strDescri, strWhere: String; Var strCodFil: String): Boolean;
    function  fAtualizaFilasImp(strCodFil, strNomImp, strDescri, strWhere: String): Boolean;
    function  fApagaFilasImp(strCodFil: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untPai, untMemo, untTypesSistema, untFuncFatImp, untCfgRel;

{$R *.dfm}

procedure TfrmCfgFilasImpressaoBoletos.FormShow(Sender: TObject);
begin
  inherited;
  qryFilas := fCriaQuery(Self);
  dspFilImp.DataSet := qryFilas;
  cdsFilImp.SetProvider(dspFilImp);
  dtsFilImp.DataSet := cdsFilImp;

  pCarregaFilas;

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

procedure TfrmCfgFilasImpressaoBoletos.pCarregaFilas;
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
    strSQL := strSQL + '  FIL_WHERE_, ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  FILBOL ';
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
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoBoletos.pCarregaFilas]');
  End
end;

procedure TfrmCfgFilasImpressaoBoletos.pEscapePressed;
begin
  If Not dbgFilImp.Enabled Then
  Begin
    dbgFilImp.Enabled := True;
    edtNomImp.Clear;
    edtDescri.Clear;
    memWhere.Clear;
    pSetFocus(edtDescri);
  End
  Else
    inherited;
end;

procedure TfrmCfgFilasImpressaoBoletos.spbShowSQLClick(Sender: TObject);
begin
  inherited;
  TfrmMemo.pShowMessage(fFormatarSQL(TFatVendaImp.fGetSQLDuplicatasBoletos(Trim(memWhere.Text))));
end;

procedure TfrmCfgFilasImpressaoBoletos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescri);
end;

procedure TfrmCfgFilasImpressaoBoletos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryFilas);
  
  inherited;
end;

procedure TfrmCfgFilasImpressaoBoletos.btnInserirClick(Sender: TObject);
  var
    strCodFilIns: String;
begin
  inherited;

  strCodFilIns := '';

  If fVerificaCampos Then
  Begin

    If (Not fEmptyStr(edtNomImp.Text)) And (dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Append;
        FieldByName('FIL_CODEMP').AsString := VS_strCodEmp;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_WHERE_').AsString := memWhere.Text;
        Post;

        If fInsereFilasImp(edtNomImp.Text, edtDescri.Text, memWhere.Text, strCodFilIns) Then
        Begin
          Edit;
          FieldByName('FIL_CODFIL').AsString := strCodFilIns;
          Post;
        End;
      End;

      edtNomImp.Clear;
      edtDescri.Clear;
      memWhere.Clear;

      pSetFocus(edtDescri);
    End
    Else If (Not fEmptyStr(edtNomImp.Text)) And (Not dbgFilImp.Enabled) Then
    Begin
      With cdsFilImp Do
      Begin
        Edit;
        FieldByName('FIL_NOMIMP').AsString := edtNomImp.Text;
        FieldByName('FIL_DESCRI').AsString := edtDescri.Text;
        FieldByName('FIL_WHERE_').AsString := memWhere.Text;
        Post;

        fAtualizaFilasImp(FieldByName('FIL_CODFIL').AsString, edtNomImp.Text, edtDescri.Text, memWhere.Text);

        strRegAtu := '';
      End;

      dbgFilImp.Enabled := True;

      edtNomImp.Clear;
      edtDescri.Clear;
      memWhere.Clear;

      pSetFocus(edtDescri);
    End;

  End;

end;

procedure TfrmCfgFilasImpressaoBoletos.btnSelImpClick(Sender: TObject);
begin
  inherited;
  edtNomImp.Text := TCfgRel.fSelecionaFila('', '', True, True);
end;

procedure TfrmCfgFilasImpressaoBoletos.dbgFilImpDblClick(Sender: TObject);
  Var
    Key: Word;
begin
  inherited;
  Key := VK_RETURN;
  dbgFilImpKeyDown(Sender, Key, []);
end;

procedure TfrmCfgFilasImpressaoBoletos.dbgFilImpKeyDown(Sender: TObject;
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
    memWhere.Text     := cdsFilImp.FieldByName('FIL_WHERE_').AsString;
    dbgFilImp.Enabled := False;
    dbgFilImp.Repaint;
    pSetFocus(edtDescri);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtNomImp.Clear;
    edtDescri.Clear;
    memWhere.Clear;

    pSetFocus(edtDescri);
  End;

end;

function TfrmCfgFilasImpressaoBoletos.fApagaFilasImp(
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
    strSQL := strSQL + '  FILBOL    ';
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
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoBoletos.fApagaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoBoletos.fAtualizaFilasImp(strCodFil, strNomImp, strDescri, strWhere: String): Boolean;
Var
  strSQL: String;
  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  FILBOL ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  FIL_NOMIMP = :NOMIMP, ';
    strSQL := strSQL + '  FIL_DESCRI = :DESCRI, ';
    strSQL := strSQL + '  FIL_WHERE_ = :WHERE_  ';
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
      ParamByName('WHERE_').AsString := strWhere;
      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgFilasImpressaoBoletos.fAtualizaFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoBoletos.fInsereFilasImp(strNomImp, strDescri, strWhere: String; Var strCodFil: String): Boolean;
Var
  strSQL: String;

  qryFilas: TUniQuery;
begin

  Result := False;

  Try

    qryFilas := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  FILBOL(             ';
    strSQL := strSQL + '         FIL_CODFIL,  ';
    strSQL := strSQL + '         FIL_CODEMP,  ';
    strSQL := strSQL + '         FIL_NOMIMP,  ';
    strSQL := strSQL + '         FIL_DESCRI,  ';
    strSQL := strSQL + '         FIL_WHERE_,  ';
    strSQL := strSQL + '         FIL_SPOIMP,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODFIL,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :NOMIMP,     ';
    strSQL := strSQL + '         :DESCRI,     ';
    strSQL := strSQL + '         :WHERE_,     ';
    strSQL := strSQL + '         :SPOIMP,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryFilas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      strCodFil := fAtualizaProCod('FILBOL', 'FIL_CODFIL');

      ParamByName('CODFIL').AsString := strCodFil;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NOMIMP').AsString := strNomImp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('WHERE_').AsString := strWhere;
      ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('FILBOL', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCfgFilasImpressaoBoletos.fInsereFilasImp]');
  End;

  FreeAndNil(qryFilas);

end;

function TfrmCfgFilasImpressaoBoletos.fValidaCampos(Sender: TWinControl;
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
  End
  Else If (Sender = edtNomImp) Then
  Begin
    If (fEmptyStr(edtNomImp.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A fila de impressão deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = memWhere) Then
  Begin
    If (fEmptyStr(memWhere.Text)) Then
    Begin
      fMensagem('ATENÇÃO','A condição where do sql deve deve ser preenchida !', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgFilasImpressaoBoletos.memWhereEnter(Sender: TObject);
begin
  inherited;
  memWhere.SelectAll;
end;

procedure TfrmCfgFilasImpressaoBoletos.memWhereKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
  If (Key = #13) Then
  Begin
    If memWhere.SelText = memWhere.Text Then
    Begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

end.
