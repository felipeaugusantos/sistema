unit untBoxEntregaTroca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, untTBoxEntrega, Data.DB, ComboBoxFocus;

type
  TResultadoAlteracao = (raAlterado, raNaoAlterado, raNovoBoxNaoDisp, raBoxAtualLiberado);

  TfrmBoxEntregaTroca = class(TfrmPai)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    grbBoxEntDisp: TGroupBox;
    cmbBoxEntDisp: TComboBoxFocus;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label5: TLabel;
    Label6: TLabel;
    edtNroBoxAtual: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtDesCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    function fGravarNumeroBox(inNroBoxAtual, intNroBoxNovo: Integer): TResultadoAlteracao;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadCli: TUniQuery;

    function  fRetAutInc(intNumeroBox : Integer) : String;
    procedure pCarregaCliente;
    procedure pCriarListaBoxDisponiveis(intNroBox: Integer);
    function fLocalizarDocMatriz(strNroDoc, strEspDoc, strCodCli, strCodEmp: String): Integer;
  public
    { Public declarations }
    objDocBoxEntrega: TDocumentoBoxEntrega;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmBoxEntregaTroca.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos()) Then
    Exit;

  If (grbBoxEntDisp.Enabled) Then
  Begin

    Case (fGravarNumeroBox(fLocalizarDocMatriz(edtNumDoc.Text, edtEspDoc.Text, edtCodCli.Text, edtCodEmp.Text),
      StrToInt(cmbBoxEntDisp.Text))) Of
      raAlterado         : fMensagem('CONFIRMAÇÃO!', 'Box de entrega alterado com sucesso!', ['&OK']);

      raNaoAlterado      : fMensagem('ERRO!', 'Box de entrega não pôde ser alterado!', ['&OK']);

      raNovoBoxNaoDisp   : fMensagem('ERRO!', 'Box de entrega selecionado não está mais disponível. Tente novamente!', ['&OK']);

      raBoxAtualLiberado : fMensagem('ERRO!', 'Box de entrega atual já foi liberado. Tente novamente!', ['&OK']);
    End;

    Close();

  End;

end;

procedure TfrmBoxEntregaTroca.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBoxEntregaTroca.edtDesCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBoxEntregaTroca.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(VS_strCodEmp);

  grbBoxEntDisp.Enabled := False;

  pSetFocus(edtNumDoc);
end;

function TfrmBoxEntregaTroca.fLocalizarDocMatriz(strNroDoc, strEspDoc,
  strCodCli, strCodEmp: String): Integer;
  Var
    i, j, k: Integer;
begin
  Result := 0;

  If (Not Assigned(objDocBoxEntrega)) Then Exit;

  For i := 0 To objDocBoxEntrega.intQtdePaginas - 1 Do
    For j := 0 To objDocBoxEntrega.intLinhasGrupo - 1 Do
      For k := 0 To objDocBoxEntrega.intQtdColunaTotal - 1 Do
        If (strNroDoc = objDocBoxEntrega.arrDocumentos[i][j][k].strNumDoc) And
           (strEspDoc = objDocBoxEntrega.arrDocumentos[i][j][k].strEspDoc) And
           (strCodCli = objDocBoxEntrega.arrDocumentos[i][j][k].strCodCli) And
           (strCodEmp = VS_strCodEmp) Then
        Begin
          Result := objDocBoxEntrega.arrDocumentos[i][j][k].intNroBox;
          Exit;
        End;
end;

procedure TfrmBoxEntregaTroca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryCadCli);
end;

procedure TfrmBoxEntregaTroca.FormCreate(Sender: TObject);
begin
  inherited;

  qryCadCli := fCriaQuery(Self);
end;

function TfrmBoxEntregaTroca.fRetAutInc(intNumeroBox: Integer): String;
var
  qryAutInc : TUniQuery;
begin

  qryAutInc := fCriaQuery(Self);

  Try

    Result := '';

    qryAutInc.Close;
    qryAutInc.SQL.Clear;
    qryAutInc.SQL.Add('SELECT       ');
    qryAutInc.SQL.Add('  AUTOINCREM ');
    qryAutInc.SQL.Add('FROM     ');
    qryAutInc.SQL.Add('  MOVGER ');
    qryAutInc.SQL.Add('WHERE    ');
    qryAutInc.SQL.Add('  GER_NROBOX = :NROBOX AND ');
    qryAutInc.SQL.Add('  GER_CODEMP = :CODEMP AND ' + objDocBoxEntrega.fRetornaSQLWhereOperacao);

    qryAutInc.ParamByName('NROBOX').AsString := intNumeroBox.ToString();
    qryAutInc.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAutInc.Open;

    If Not qryAutInc.IsEmpty Then
      Result := qryAutInc.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryAutInc);
  End;

end;

function TfrmBoxEntregaTroca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intNroBoxDocSel: Integer;
begin

  Result := True;

  If (Sender = edtCodCli) Then
  Begin

    If (fEmptyStr(edtCodCli.Text)) Then
    Begin
      edtDesCli.Clear;
    End
    Else
    Begin

      pCarregaCliente;

      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este cliente não está cadastrado!', ['&OK']);
        Result := False;
      End
      Else
      Begin

        intNroBoxDocSel := fLocalizarDocMatriz(edtNumDoc.Text, edtEspDoc.Text, edtCodCli.Text, edtCodEmp.Text);

        If (intNroBoxDocSel > 0) Then
        Begin
          pCriarListaBoxDisponiveis(intNroBoxDocSel);
          edtNroBoxAtual.Text := IntToStr(intNroBoxDocSel);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Documento informado não foi encontrado!', ['&OK']);
          edtNroBoxAtual.Text := '';
          Result := False;
          Sender := edtNumDoc;
        End;

      End;

    End;

  End

  Else If (Sender = cmbBoxEntDisp) And (grbBoxEntDisp.Enabled) Then
  Begin
    If (cmbBoxEntDisp.Items.IndexOf(cmbBoxEntDisp.Text) = -1) Then
    Begin
      fMensagem('ATENÇÃO!', 'Box de entrega selecionado não foi encontrado, verifique!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmBoxEntregaTroca.pCarregaCliente;
begin
  With qryCadCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                 ');
    SQL.Add('  *                    ');
    SQL.Add('FROM                   ');
    SQL.Add('  CADCLI               ');
    SQL.Add('WHERE                  ');
    SQL.Add('  CLI_CODCLI = :CODCLI ');

    ParamByName('CODCLI').AsString := edtCodCli.Text;

    Open;

    edtDesCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmBoxEntregaTroca.pCriarListaBoxDisponiveis(intNroBox: Integer);
  Var
    i, j, k: Integer;
begin
  If (Not Assigned(objDocBoxEntrega)) Or (grbBoxEntDisp.Enabled) Then
    Exit;

  cmbBoxEntDisp.Clear();

  For i := 0 To objDocBoxEntrega.intQtdePaginas - 1 Do
    For j := 0 To objDocBoxEntrega.intLinhasGrupo - 1 Do
      For k := 0 To objDocBoxEntrega.intQtdColunaTotal - 1 Do
        If (fEmptyStr(objDocBoxEntrega.arrDocumentos[i][j][k].strCodCli)) And
          (objDocBoxEntrega.arrDocumentos[i][j][k].intNroBox > 0) And
          (objDocBoxEntrega.arrDocumentos[i][j][k].intNroBox <= fCfgSis(IIF(objDocBoxEntrega.fEhOperacaoDeRetira, 'QTDBOX', 'QTDBEI'), varInteger)) Then
          cmbBoxEntDisp.Items.Add(IntToStr(objDocBoxEntrega.arrDocumentos[i][j][k].intNroBox));

  cmbBoxEntDisp.ItemIndex := 0;
  grbBoxEntDisp.Enabled   := (cmbBoxEntDisp.Items.Count > 0);
end;

function TfrmBoxEntregaTroca.fGravarNumeroBox(inNroBoxAtual, intNroBoxNovo: Integer): TResultadoAlteracao;
  Var
    qryTemp   : TUniQuery;
    strAutInc : String;
begin

  Try

    qryTemp := fCriaQuery(Self);
    Result  := raNaoAlterado;

    Try

      strAutInc := fRetAutInc(intNroBoxNovo);

      If (fEmptyStr(strAutInc)) Then
      Begin

        strAutInc := fRetAutInc(inNroBoxAtual);

        If (Not fEmptyStr(strAutInc)) Then
        Begin

          qryTemp.SQL.Clear();
          qryTemp.SQL.Text := 'UPDATE MOVGER SET GER_NROBOX = :NROBOXNOV WHERE GER_NROBOX = :NROBOXANT AND GER_CODEMP = :CODEMP AND ' + objDocBoxEntrega.fRetornaSQLWhereOperacao;
          qryTemp.ParamByName('NROBOXANT').AsInteger := inNroBoxAtual;
          qryTemp.ParamByName('NROBOXNOV').AsInteger := intNroBoxNovo;
          qryTemp.ParamByName('CODEMP').AsString     := VS_strCodEmp;
          qryTemp.ExecSQL();

          Result  := raAlterado;

        End
        Else
        Begin
          Result  := raBoxAtualLiberado;  //INDICA QUE O BOX ATUAL JÁ FOI LIBERADO E NÃO PODE MAIS SER ALTERADO
        End;

      End
      Else
      Begin
        Result  := raNovoBoxNaoDisp;  //INDICA QUE O NOVO BOX JÁ ESTÁ EM USO E NÃO PODE MAIS SER ESCLHIDO
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBoxEntregaTroca.fGravarNumeroBox]');
    End;

  Finally
    FreeAndNil(qryTemp);
  End;

end;

end.
