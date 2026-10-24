unit untSelecionarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus, Uni,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Data.DB, untFuncoesConsulta, untFuncoesSimples,
  untTypesSistema;

Type
  TTipoNota = (tnEntrada, tnSaida);

type
  TfrmSelecionarNota = class(TfrmPai)
    gbDadosNF: TGroupBox;
    Label1: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSerie_: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
  private
    { Private declarations }
    arrEmp: TConsultasArray;
    function fValidaNotaFiscal: Boolean;
  public
    { Public declarations }
    tnTipoNota: TTipoNota;
    blnConfirma: Boolean;
    strSeqGer: String;
    strCodCli: String;
    dtaDtaGer: TDateTime;
    strAcesso: String;

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untConsultas;

procedure TfrmSelecionarNota.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmSelecionarNota.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmSelecionarNota.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelecionarNota.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmSelecionarNota.FormCreate(Sender: TObject);
begin
  inherited;
  strCodCli   := '';
  blnConfirma := False;
  strSeqGer   := '';
  dtaDtaGer   := 0;
  strAcesso   := '';
end;

procedure TfrmSelecionarNota.FormShow(Sender: TObject);
begin
  inherited;

  If tnTipoNota = tnEntrada Then
    gbDadosNF.Caption := 'Dados da Nota de Entrada'
  Else
    gbDadosNF.Caption := 'Dados da Nota de Saída';
end;

function TfrmSelecionarNota.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End;

        If Result Then
        Begin
          If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If Not fValidaNotaFiscal Then
            Begin
              fMensagem('ATENÇÃO!', 'Nota Fiscal não encontrada. Certifique-se dos dados informados e que o documento refere-se ao cliente informado na OS!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma Empresa!', ['&O k']);
        Result := False;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmSelecionarNota.fValidaNotaFiscal: Boolean;
  Var
    strSQL: String;
    qryDocCon: TUniQuery;
begin
  Try
    qryDocCon := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   MOVGER.AUTOINCREM, ';
    strSQL := strSQL + '   GER_DTAENT, ';
    strSQL := strSQL + '   FIS_ACESSO  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVGER ';
    strSQL := strSQL + '   JOIN AUXMOV ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM) ';
    strSQL := strSQL + '   LEFT JOIN CADFIS ';
    strSQL := strSQL + '     ON FIS_NUMDOC = GER_NUMDOC ';
    strSQL := strSQL + '    AND FIS_ESPDOC = GER_ESPDOC ';
    strSQL := strSQL + '    AND FIS_FORCLI = GER_CODCLI ';
    strSQL := strSQL + '    AND FIS_CODEMP = GER_CODEMP ';
    strSQL := strSQL + '    AND FIS_ENTSAI = "E" ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   GER_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '   GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   LOCATE(GER_CLAFIS, :CLAFIS) > 0 ';

    If (Not fCfgSis('PMOEOS', varBoolean)) Then
      strSQL := strSQL + ' AND AUX_CONEQU = "S" ';

    If (Not fEmptyStr(strCodCli)) Then
      strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';

    With qryDocCon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('SERIE_').AsString := edtSerie_.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If (Not fEmptyStr(strCodCli)) Then
        ParamByName('CODCLI').AsString := strCodCli;

      If tnTipoNota = tnEntrada Then
        ParamByName('CLAFIS').AsString := fTransform(fCfgSisL('CLACON'), 4)
      Else
        ParamByName('CLAFIS').AsString := fTransform(fCfgSisL('CLASAI'), 4);

      Open;

      Result := Not IsEmpty;

      If Result Then
      Begin
        strSeqGer := FieldByName('AUTOINCREM').AsString;
        dtaDtaGer := FieldByName('GER_DTAENT').AsDateTime;
        strAcesso := FieldByName('FIS_ACESSO').AsString;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmSelecionarNota.fValidaNotaFiscal]');
    End;
  End;

  FreeAndNil(qryDocCon);
end;

end.
