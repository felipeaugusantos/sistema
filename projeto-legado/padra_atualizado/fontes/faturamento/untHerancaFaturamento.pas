unit untHerancaFaturamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, ExtCtrls, untTypesSistema, untFuncoesSimples, Uni,
  StrUtils, frxClass, frxExportCSVTestabilidade, Data.DB;

type
  TfrmHerancaFaturamento = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    arrEmp: TConsultasArray;
    function fExisteDocumento: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryDoc: TUniQuery;
  end;

var
  frmHerancaFaturamento: TfrmHerancaFaturamento;

implementation

uses untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmHerancaFaturamento.edtCodEmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

  If fEmptyStr(edtCodEmp.Text)Then
    edtNomEmp.Text := '';
end;

procedure TfrmHerancaFaturamento.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmHerancaFaturamento.fExisteDocumento: Boolean;
  Var
    strSQL: String;
begin
  Try
    qryDoc := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT                                                 ';
    strSQL := strSQL + '   "MOVDET" AS TABELA,                                  ';
    strSQL := strSQL + '   GER_ORIDOC,                                          ';
    strSQL := strSQL + '   GER_TIP_FC,                                          ';
    strSQL := strSQL + '   GER_CLAFIS,                                          ';
    strSQL := strSQL + '   DET_CODITE,                                          ';
    strSQL := strSQL + '   DET_NUMLOT,                                          ';
    strSQL := strSQL + '   DET_QTDITE                                           ';
    strSQL := strSQL + ' FROM                                                   ';
    strSQL := strSQL + '   MOVDET                                               ';
    strSQL := strSQL + ' JOIN MOVGER ON (MOVGER.AUTOINCREM = MOVDET.DET_SEQGER) ';
    strSQL := strSQL + ' WHERE                                                  ';
    strSQL := strSQL + '   GER_TIP_FC = "C"     AND                             ';
    strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND                             ';
    strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND                             ';
    strSQL := strSQL + '   DET_CODEMP = :CODEMP                                 ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET','NOTDET'), 'MOVGER','NOTGER');

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT                                                 ';
    strSQL := strSQL + '   "FATDOR" AS TABELA,                                  ';
    strSQL := strSQL + '   "V" AS GER_ORIDOC,                                   ';
    strSQL := strSQL + '   "C" AS GER_TIP_FC,                                   ';
    strSQL := strSQL + '   FDO_CLAFIS AS GER_CLAFIS,                            ';
    strSQL := strSQL + '   FDO_CODITE AS DET_CODITE,                            ';
    strSQL := strSQL + '   FDO_NUMLOT AS DET_NUMLOT,                            ';
    strSQL := strSQL + '   FDO_QTDITE AS DET_QTDITE                             ';
    strSQL := strSQL + ' FROM                                                   ';
    strSQL := strSQL + '   FATDOR                                               ';
    strSQL := strSQL + ' JOIN FATGOR ON (FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER) ';
    strSQL := strSQL + ' WHERE                                                  ';
    strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND                             ';
    strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND                             ';
    strSQL := strSQL + '   FDO_CODEMP = :CODEMP                                 ';

    With qryDoc Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

      Open;

      Result := Not IsEmpty;

      If Not Result Then
        pMensagemOk('O documento selecionado não existe.')
      Else
      Begin
        Result := SameText(FieldByName('GER_TIP_FC').AsString, 'C') And
                  SameText(FieldByName('GER_ORIDOC').AsString, 'V');

        If Not Result Then
          pMensagemOk('É permitido herdar apenas documentos de venda para clientes.')
        Else
        Begin
          Result := Pos(edtEspDoc.Text, 'ML_PR_TM_TR_' + IIF(FieldByName('GER_CLAFIS').AsString < '5000', edtEspDoc.Text + '_', '')) <= 0;

          If Not Result Then
            pMensagemOk('É permitido herdar apenas documentos de venda para clientes.');
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmHerancaFaturamento.fExisteDocumento]');
    End;
  End;

  If Not Result Then
    FreeAndNil(qryDoc);
end;

procedure TfrmHerancaFaturamento.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmHerancaFaturamento.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

function TfrmHerancaFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = edtNumDoc) Then
      Begin
        If fEmptyStr(edtNumDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Defina o número do documento.', ['&OK']);
          Result := False;
        End;
      End
      Else If (Sender = edtEspDoc) Then
      Begin
        If fEmptyStr(edtEspDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Defina a espécie do documento.', ['&OK']);
          Result := False;
        End;
      End
      Else If (Sender = edtCodEmp) Then
      Begin
        If fEmptyStr(edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Defina uma empresa.', ['&OK']);
          Result := False;
        End
        Else
        Begin
          edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

          If fEmptyStr(edtNomEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Empresa não cadastrada.', ['&OK']);
            Result := False;
          End
          Else
          Begin
            If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
            Begin
              fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa.', ['&OK']);
              Result := False;
            End;
          End;
        End;

        If Result Then
          Result := fExisteDocumento;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmHerancaFaturamento.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
