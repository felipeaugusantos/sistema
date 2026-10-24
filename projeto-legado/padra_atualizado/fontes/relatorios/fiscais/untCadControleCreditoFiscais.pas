unit untCadControleCreditoFiscais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids,
  DBGridCitel, DBGrids, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB;

type
  TfrmCadControleCreditoFiscais = class(TfrmPaiCad)
    Label40: TLabel;
    edtdbeMesAno: TDBEditFocus;
    Label1: TLabel;
    edtdbeCodAjuAp: TDBEditFocus;
    Label2: TLabel;
    edtdbeSalCred: TDBEditFocus;
    Label3: TLabel;
    edtdbeSalAp: TDBEditFocus;
    Label4: TLabel;
    edtdbeCredRec: TDBEditFocus;
    Label5: TLabel;
    edtdbeCredUti: TDBEditFocus;
    dbgrControlCredFisc: TDBGridCitel;
    dtsControlCredFisc: TDataSource;
    edtdbeTipCre: TDBEditFocus;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbgrControlCredFiscKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsControlCredFiscStateChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure pFormataCampos;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadControleCreditoFiscais: TfrmCadControleCreditoFiscais;

implementation

uses untIFuncoes, untFuncoesSimples, untTypesSistema, Uni, StrUtils, DbAccess;

{$R *.dfm}

procedure TfrmCadControleCreditoFiscais.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pSetFocus(edtdbeMesAno);
end;

procedure TfrmCadControleCreditoFiscais.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadControleCreditoFiscais.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadControleCreditoFiscais.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If dtsControlCredFisc.State in [dsInsert] Then
    Begin
      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COCFIS', VS_strCodEmp);
      qryTabela.FieldByName('COC_CODEMP').AsString := VS_strCodEmp;
    End;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadControleCreditoFiscais.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pSetFocus(dbgrControlCredFisc);
end;

procedure TfrmCadControleCreditoFiscais.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pSetFocus(edtdbeMesAno);
end;

procedure TfrmCadControleCreditoFiscais.btnPesquisaClick(Sender: TObject);
  Var
    strSQL, strSQLWhere: String;
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COC_MESANO, '; pAddNomeColuna('Data');
  strSQL := strSQL + '  COC_CODAJU, '; pAddNomeColuna('Código');
  strSQL := strSQL + '  COC_SLDCRE, ';
  strSQL := strSQL + '  COC_CREAPR, ';
  strSQL := strSQL + '  COC_CREREC, ';
  strSQL := strSQL + '  COC_CREUTI, ';
  strSQL := strSQL + '  COC_CODEMP, ';
  strSQL := strSQL + '  COC_TIPCRE, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COCFIS ';

  strSQLWhere := strSQLWhere + 'WHERE COC_CODEMP = ' + QuotedStr(VS_strCodEmp);

  qryConsulta := fCriaQuery(Nil);
  Try
    If fConsulta([strSQL, strSQLWhere],
                 arrTitCol,
                 ['COC_MESANO'],
                 'AUTOINCREM',
                 'COCFIS',
                 Self.Name,
                 'Cadastro de Controle de Créditos Fiscais',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      qryTabela.Locate('COC_MESANO;COC_CODEMP;AUTOINCREM', VarArrayOf([qryConsulta.FieldByName('COC_MESANO').AsString,
                                                                       qryConsulta.FieldByName('COC_CODEMP').AsString,
                                                                       qryConsulta.FieldByName('AUTOINCREM').AsString]), []);

      edtdbeMesAno.Text := qryConsulta.FieldByName('COC_MESANO').AsString;
      edtdbeCodAjuAp.Text := qryConsulta.FieldByName('COC_CODAJU').AsString;
      edtdbeTipCre.Text := qryConsulta.FieldByName('COC_TIPCRE').AsString;
      edtdbeSalCred.Text := FloatToStrF(qryConsulta.FieldByName('COC_SLDCRE').AsFloat, ffNumber, 015, 002);
      edtdbeSalAp.Text := FloatToStrF(qryConsulta.FieldByName('COC_CREAPR').AsFloat, ffNumber, 015, 002);
      edtdbeCredRec.Text := FloatToStrF(qryConsulta.FieldByName('COC_CREREC').AsFloat, ffNumber, 015, 002);
      edtdbeCredUti.Text := FloatToStrF(qryConsulta.FieldByName('COC_CREUTI').AsFloat, ffNumber, 015, 002);

      btnAlterarClick(Sender);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadControleCreditoFiscais.dbgrControlCredFiscKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    btnAlterarClick(Sender);
end;

procedure TfrmCadControleCreditoFiscais.dtsControlCredFiscStateChange(Sender: TObject);
begin
  inherited;
  If dtsControlCredFisc.State in [dsBrowse] Then
    dbgrControlCredFisc.Enabled := True
  Else
    dbgrControlCredFisc.Enabled := False;
end;

procedure TfrmCadControleCreditoFiscais.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'COCFIS';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM COCFIS WHERE COC_CODEMP = :CODEMP', Self);
  qryTabela.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryTabela.FieldByName('COC_MESANO').EditMask := '99/9999';

  pFormataCampos;

  dtsControlCredFisc.DataSet := qryTabela;
end;

procedure TfrmCadControleCreditoFiscais.FormShow(Sender: TObject);
begin
  inherited;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.sql.Text := 'SELECT CAST(CONCAT(RIGHT(COC_MESANO, 04), LEFT(COC_MESANO, 02), "01") AS DATE) NOVA_DATA, COCFIS.* FROM COCFIS WHERE COC_CODEMP = :CODEMP ORDER BY NOVA_DATA DESC ';
  qryTabela.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryTabela.FieldByName('COC_MESANO').EditMask := '99/9999';

  pFormataCampos;

  qryTabela.Open;
end;

function TfrmCadControleCreditoFiscais.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try
      StrToDate('01/' + edtdbeMesAno.Text);
    Except
      fMensagem('', 'Valor inválido para o campo Mês / Ano!', ['&Ok']);
      Result := False;
    End;

    Try
      strToInt(RightStr(edtdbeMesAno.Text, 04));
      strToInt(LeftStr(edtdbeMesAno.Text, 02));
    Except
      fMensagem('', 'Informe o mês com dois dígitos e o ano com quatro dígitos, no formato 99/9999!', ['&Ok']);
      Result := False;
    End;

    If Sender = edtdbeCodAjuAp Then
    Begin
      If fEmptyStr(edtdbeCodAjuAp.Text) Then
      Begin
        fMensagem('','O campo código do ajuste deve ser preenchido! Favor inserir os campos novamente', ['&OK']);
        Result := False;
        Exit;
      End;

      If (Not fValidaEstado(LeftStr(edtdbeCodAjuAp.Text, 02))) Then
      Begin
        fMensagem('ATENÇÃO', 'Os dois primeiros caracteres do campo código do ajuste representando o estado não é válido! Favor inserir os campos novamente.', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;

    If Sender = edtdbeTipCre Then
    Begin
      If fEmptyStr(edtdbeTipCre.Text) Then
      Begin
        fMensagem('','O campo "Cód. Tipo Útil 1210" deve ser preenchido! Favor inserir os campos novamente', ['&OK']);
        Result := False;
        Exit;
      End;

      If (Not fValidaEstado(LeftStr(edtdbeTipCre.Text, 02))) Then
      Begin
        fMensagem('ATENÇÃO', 'Os dois primeiros caracteres do campo "Cód. Tipo Útil 1210" representando o estado não é válido! Favor inserir os campos novamente.', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;

    If (Sender = edtdbeSalCred) Then
    Begin
      If fEmptyStr(edtdbeSalCred.Text) Then
      Begin
        fMensagem('', 'O valor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtdbeSalAp) Then
    Begin
      If fEmptyStr(edtdbeSalAp.Text) Then
      Begin
        fMensagem('', 'O valor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtdbeCredRec) Then
    Begin
      If fEmptyStr(edtdbeCredRec.Text) Then
      Begin
        fMensagem('', 'O valor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtdbeCredUti) Then
    Begin
      If fEmptyStr(edtdbeCredUti.Text) Then
      Begin
        fMensagem('', 'O valor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

    If (fStrToFloat(edtdbeSalCred.Text) < 0) Or
       (fStrToFloat(edtdbeSalAp.Text) < 0) Or
       (fStrToFloat(edtdbeCredRec.Text) < 0) Or
       (fStrToFloat(edtdbeCredUti.Text) < 0) Then
    Begin
      fMensagem('', 'Valores de créditos fiscais não podem ser negativos!', ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmCadControleCreditoFiscais.pFormataCampos;
begin
  TFloatField(qryTabela.FieldByName('COC_SLDCRE')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('COC_SLDCRE')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('COC_CREAPR')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('COC_CREAPR')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('COC_CREREC')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('COC_CREREC')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('COC_CREUTI')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('COC_CREUTI')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadControleCreditoFiscais.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('COC_MESANO');
  stlCampos.Add('COC_CODAJU');
  stlCampos.Add('COC_TIPCRE');
  stlCampos.Add('COC_SLDCRE');
  stlCampos.Add('COC_CREAPR');
  stlCampos.Add('COC_CREREC');
  stlCampos.Add('COC_CREUTI');
  stlCampos.Add('COC_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COC_CODEMP');
  stlCamInd.Add('COC_MESANO');
  stlCamInd.Add('COC_CODAJU');
  stlCamInd.Add('COC_TIPCRE');
end;

end.
