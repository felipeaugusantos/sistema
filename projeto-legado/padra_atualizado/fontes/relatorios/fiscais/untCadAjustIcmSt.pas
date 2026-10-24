unit untCadAjustIcmSt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Data.DB, MemDS, DBAccess,
  Uni, Vcl.Grids, DBGridCitel, DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, strUtils;

type
  TfrmCadAjustIcmSt = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    qryAjuste: TUniQuery;
    dbgridAjuste: TDBGridCitel;
    Label40: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtdbeMesAno: TDBEditFocus;
    edtdbeCodAju: TDBEditFocus;
    edtdbeDescricao: TDBEditFocus;
    edtdbeValAju: TDBEditFocus;
    edtdbeCodRec: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure phabilitaGrid;
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAjustIcmSt.btnAlterarClick(Sender: TObject);
begin
  inherited;

  phabilitaGrid;
end;

procedure TfrmCadAjustIcmSt.btnCancelaClick(Sender: TObject);
begin
  inherited;

  phabilitaGrid;
end;

procedure TfrmCadAjustIcmSt.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustIcmSt.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAjustIcmSt.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJICST', VS_strCodEmp);
    qryTabela.FieldByName('AJI_CODEMP').AsString := VS_strCodEmp;

    phabilitaGrid;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustIcmSt.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAjustIcmSt.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtdbeMesAno);
  phabilitaGrid;
end;

procedure TfrmCadAjustIcmSt.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
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
  strSQL := strSQL + '  AJI_MESANO, '; pAddNomeColuna('Data');
  strSQL := strSQL + '  AJI_CODAJU, '; pAddNomeColuna('Cód. Ajuste');
  strSQL := strSQL + '  AJI_DESAJU, '; pAddNomeColuna('Descricao');
  strSQL := strSQL + '  AJI_CODEMP, '; pAddNomeColuna('Empresa');
  strSQL := strSQL + '  AJI_CODREC, '; pAddNomeColuna('Cód. Receita (E250)');
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  AJICST ';

  qryConsulta := fCriaQuery(Nil);
  Try
    If fConsulta([strSQL],
                 arrTitCol,
                 ['AJI_CODAJU'],
                 'AUTOINCREM',
                 'AJICST',
                 Self.Name,
                 'Cadastro de Ajuste de ICMS-ST',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      qryTabela.Locate('AUTOINCREM', VarArrayOf([qryConsulta.FieldByName('AUTOINCREM').AsString]), []);

      edtdbeMesAno.Text := qryConsulta.FieldByName('AJI_MESANO').AsString;
      edtdbeCodAju.Text := qryConsulta.FieldByName('AJI_CODAJU').AsString;
      edtdbeCodRec.Text := qryConsulta.FieldByName('AJI_CODREC').AsString;
      edtdbeDescricao.Text := qryConsulta.FieldByName('AJI_DESAJU').AsString;
      edtdbeValAju.Text := FloatToStrF(qryConsulta.FieldByName('AJI_VALAJU').AsFloat, ffNumber, 015, 002);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadAjustIcmSt.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'AJICST';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM AJICST WHERE AJI_CODEMP = :CODEMP', Self);
  qryTabela.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryTabela.FieldByName('AJI_MESANO').EditMask := '99/9999';

  TFloatField(qryTabela.FieldByName('AJI_VALAJU')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJI_VALAJU')).DisplayFormat := '#,##0.00';

  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCadAjustIcmSt.FormShow(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

function TfrmCadAjustIcmSt.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    blnValida: Boolean;
    strCodigoAjuste: String;
begin
  Result := True;

  blnValida := False;

  strCodigoAjuste := edtdbeMesAno.Text + edtdbeCodAju.Text + VS_strCodEmp;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtdbeCodAju) And (edtdbeCodAju.Enabled) Then
    Begin
      If fEmptyStr(edtdbeCodAju.Text) Then
      Begin
        fMensagem('','O campo código do ajuste deve ser preenchido! Favor inserir os campos novamente', ['&OK']);
        Result := False;
        Exit;
      End;

      If (Not fValidaEstado(LeftStr(edtdbeCodAju.Text, 02))) Then
      Begin
        fMensagem('ATENÇÃO', 'Os dois primeiros caracteres do campo código do ajuste representando o estado não é valido! Favor inserir os campos novamente.', ['&Ok']);
        Result := False;
        Exit;
      End;

      Try
        If Length(edtdbeCodAju.Text) <> 8 Then
        Begin
          blnValida := True;
          Abort;
        End;

        StrToInt(LeftStr(edtdbeCodAju.Text, 02));
        blnValida := True;
        Abort;
      Except
        If blnValida Then
        Begin
          fMensagem('', 'Informe no campo código do ajuste os dois primeiros caracteres com um estado válido e os seis últimos com o código do ajuste!', ['&OK']);
          Result := False;
          Exit;
        End;
      End;
    End;

    If (Sender = edtdbeMesAno) And (edtdbeMesAno.Enabled) Then
    Begin
      Try
        If (Length(Trim(edtdbeMesAno.Text)) < 7) then
          Abort;

        StrToDate('01/' + edtdbeMesAno.Text);
      Except
        fMensagem('', 'Valor inválido para o campo Mês / Ano! Favor inserir os campos novamente.', ['&Ok']);
        Result := False;
        Exit;
      End;

      Try
        strToInt(RightStr(edtdbeMesAno.Text, 04));
        strToInt(LeftStr(edtdbeMesAno.Text, 02));
      Except
        fMensagem('', 'Informe o mês com dois dígitos e o ano com quatro dígitos, no formato 99/9999!', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;

    If (Sender = edtdbeValAju) Then
    Begin
      If (fStrToFloat(edtdbeValAju.Text) <= 0) Then
      Begin
        fMensagem('', 'Valor do ajuste deve ser maior que zero! Favor inserir os campos novamente.', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtdbeCodRec) And (edtdbeCodRec.Enabled) Then
    Begin
      If fEmptyStr(edtdbeCodRec.Text) Then
      Begin
        fMensagem('','O campo código da receita deve ser preenchido! Favor inserir os campos novamente', ['&OK']);
        Result := False;
        Exit;
      End;
    End;
  End;
end;

procedure TfrmCadAjustIcmSt.pHabilitaGrid;
begin
  dbgridAjuste.Enabled := Not (dbgridAjuste.Enabled);
end;

procedure TfrmCadAjustIcmSt.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AJI_MESANO');
  stlCampos.Add('AJI_CODAJU');
  stlCampos.Add('AJI_DESAJU');
  stlCampos.Add('AJI_VALAJU');
  stlCampos.Add('AJI_CODREC');
  stlCampos.Add('AJI_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJI_MESANO');
  stlCamInd.Add('AJI_CODAJU');
  stlCamInd.Add('AJI_DESAJU');
  stlCamInd.Add('AJI_VALAJU');
  stlCamInd.Add('AJI_CODREC');
  stlCamInd.Add('AJI_CODEMP');
end;

end.
