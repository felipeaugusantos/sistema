unit untRelBancSaldosPor;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni, untTypesSistema,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, Menus, QColorLabel, Math, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;
    
type
  TfrmRelBancSaldosPor = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPortador: TEditFocus;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    rdgOpcao: TRadioGroup;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    procedure pGeraExcel;
    function fPortadorAtivo: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrEmpresa  : TConsultasArray;
    arrPortador : TConsultasArray;
    strEmpresa  : String;
    strPortador : String;
  end;

var
  frmRelBancSaldosPor: TfrmRelBancSaldosPor;

implementation

uses untQckBancSaldosPor, untPai, Data.DB, untFuncoesFactory, untIFuncoes,
  untExcel;

{$R *.dfm}

procedure TfrmRelBancSaldosPor.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False, 'Consulta de Portadores', '', True) Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBancSaldosPor.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  SelectFirst;
end;

function TfrmRelBancSaldosPor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************AF*}
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        If Not fEmptyStr(edtCodPor.Text) Then
        Begin
          If Not fPortadorAtivo then
          Begin
            fMensagem('ATENÇÃO!', 'O portador não esta configurado. Verificar cadastro de Portadores!', ['&O k']);
            edtDesPortador.Text := '';
            Result := False;
            Exit;
          End;

        end;

        If StrToDate(mskDtaIni.Text) <= fRetDataPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!','O portador solicitado tem como data inicial de saldo' + {#13 +}
            ' o dia ' + DateTimeToStr(fRetDataPortador(edtCodPor.Text)) + ', portanto você não pode solicitar uma' +
            ' consulta anterior a esta data.',['&O K']);
          Result := False;
        End
        Else
        Begin
          edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);
          If fEmptyStr(edtDesPortador.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End
      Else If fEmptyStr(edtCodPor.Text) Then
        edtDesPortador.Text := 'TODOS';
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp,ArrEmpresa);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelBancSaldosPor.fPortadorAtivo: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := False;
  Try
    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  POR_SALPOR           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADPOR               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  POR_CODPOR = :CODPOR ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPOR').AsString := edtCodPor.Text;
      Open;

      If (qryGen.FieldByName('POR_SALPOR').AsString = 'S') Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmRelBancSaldosPor.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelBancSaldosPor.pGeraExcel;
  Var
    objExcel   : TExcel;
    fltSaldo   : Double;
    fltSalGer  : Double;
    strUltLet  : String;
    strOpcao   : String;
    sitLan     : TSituacaoLancBancario;
begin

  fltSalGer:= 0;
  strUltLet:= 'C';

  sitLan :=  sitTodos;
  case rdgOpcao.ItemIndex  of
     0:  sitLan :=  sitConciliado;
     1:  sitLan :=  sitNaoConciliado;
  end;


  case rdgOpcao.ItemIndex  of
     0:  strOpcao := 'OPÇÃO: CONCILIADOS';
     1:  strOpcao := 'OPÇÃO: NÃO CONCILIADOS';
     2:  strOpcao := 'OPÇÃO: TODOS';
  end;


  Try
    objExcel := TExcel.fCriarExcel(Self);

    If Not objExcel.CriarArquivo Then
    begin
      FreeAndNil(objExcel);
      Exit;
    End;

    With objExcel Do
    Begin
      LinhaAtual := 01;

      Escrever(ProximaLinha, 01, fRetNomeEmpresaSelec(VS_strCodEmp));
      Escrever(ProximaLinha, 01, 'RELATORIO DE SALDOS POR PORTADOR ');
      Negrito('A2', 'C3', True);
      CorFundo('A2', 'C3', Cinza);
      Escrever(ProximaLinha, 01, 'REFERENTE A DATA PARA SALDO ' + mskDtaIni.Text);
      ProximaLinha;

      Escrever(ProximaLinha, 01, fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR'));
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmpresa, strEmpresa, 'EMPRESA'));
      ProximaLinha;

      Escrever(LinhaAtual,01, strOpcao);
      ProximaLinha;

      Mesclar('A1', strUltLet + '1');
      Mesclar('A2', strUltLet + '2');
      Mesclar('A3', strUltLet + '3');
      Mesclar('A4', strUltLet + '4');
      Mesclar('A5', strUltLet + '5');
      Mesclar('A6', strUltLet + '6');
      Mesclar('A7', strUltLet + '7');
      Mesclar('A8', strUltLet + '8');
      Alinhamento('A1', 'C8', Centro);

      Escrever(LinhaAtual, 01, 'CODIGO');
      Escrever(LinhaAtual, 02, 'NOME DO PORTADOR');
      Escrever(LinhaAtual, 03, 'SALDO');
      Alinhamento(LinhaAtual, 03, Direita);
      Negrito('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), True);
      CorFundo('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Cinza);
      Bordas('A1', strUltLet + '9');

      qryRelatorio.First;

      While Not qryRelatorio.Eof Do
      Begin
        ProximaLinha;
        Escrever(LinhaAtual, 01, qryRelatorio.FieldByName('POR_CODPOR').AsString);
        Escrever(LinhaAtual, 02, qryRelatorio.FieldByName('POR_NOMPOR').AsString);
        fltSaldo := fRetSaldoAnterior(qryRelatorio.FieldByName('POR_CODPOR').AsString,StrToDate(mskDtaIni.Text),strEmpresa, sitLan);
        Escrever(LinhaAtual, 03, FormatFloat('#,##0.00', fltSaldo));
        Alinhamento(LinhaAtual, 03, Direita);

        fltSalGer := fltSalGer + fltSaldo;

        qryRelatorio.Next;
      End;

      Escrever(ProximaLinha, 01, 'SALDO GERAL:');
      Escrever(LinhaAtual, 03, FormatFloat('#,##0.00', fltSalGer));
      Alinhamento(LinhaAtual, 03, Direita);
      Negrito('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual), True);
      Bordas('A' + IntToStr(LinhaAtual), strUltLet + IntToStr(LinhaAtual));

      CongelarPaines('A9');
      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
    End;
  Except
    On E: Exception Do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TfrmRelBancSaldosPor.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    intContador: Integer;
begin

  inherited;

  If Not blnImprime Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  P.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPOR P ';

  strSQL := strSQL + ' WHERE P.POR_SALPOR = "S" ';

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor, arrPortador,'P.POR_CODPOR','CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(P.POR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(P.POR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '  P.POR_NOMPOR ';

  With qryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);
    Open;
  End;

  If Not qryRelatorio.IsEmpty Then
  Begin
    Try

      pCriarFormularios(TfrmQckBancSaldosPor,frmQckBancSaldosPor);

      frmQckBancSaldosPor.dtsRelatorio.DataSet := qryRelatorio;

      strEmpresa := '';

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin

        If Length(arrEmpresa) > 1 Then
        Begin
          strEmpresa := '';
          For intContador := 0 To Length(arrEmpresa)-1 Do
          Begin
            strEmpresa := strEmpresa + arrEmpresa[intContador].strCodigo + '_';
          End;

        End
        Else
          strEmpresa := edtCodEmp.Text;

      End
      Else
        strEmpresa := strEmpAcessoUsuarioLogado;

      If edtDesTino.Text <> 'E' Then
      Begin
        If strTipImp = 'M' Then
          frmQckBancSaldosPor.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckBancSaldosPor.qckPagina.DefaultFilter := Nil;

        frmQckBancSaldosPor.strCodEmp := strEmpresa;

        frmQckBancSaldosPor.rllOpcao.Caption := 'OPÇÃO: TODOS';
        case rdgOpcao.ItemIndex  of
           0:
           begin
             frmQckBancSaldosPor.sitLan :=  sitConciliado;
             frmQckBancSaldosPor.rllOpcao.Caption := 'OPÇÃO: CONCILIADOS';
           end;
           1:
           begin
             frmQckBancSaldosPor.sitLan :=  sitNaoConciliado;
             frmQckBancSaldosPor.rllOpcao.Caption := 'OPÇÃO: NÃO CONCILIADOS';
           end;
           2:  frmQckBancSaldosPor.sitLan :=  sitTodos;
        end;

        frmQckBancSaldosPor.rllNomeRelatorio.Caption := 'RELATORIO DE SALDOS POR PORTADOR ';
        frmQckBancSaldosPor.strOrdem := 'REFERENTE A DATA PARA SALDO: ' + mskDtaIni.Text;
        frmQckBancSaldosPor.rllEmpresa.Caption  := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmpresa, strEmpresa, 'EMPRESA');
        frmQckBancSaldosPor.rllPortador.Caption := fStrTitulo(edtCodPor.Text, edtDesPortador, arrPortador, strPortador, 'PORTADOR');
        frmQckBancSaldosPor.dtaDataFinal := StrToDate(mskDtaIni.Text);

        If edtDestino.Text = 'V' Then
          frmQckBancSaldosPor.qckPagina.PreviewModal
        Else
          frmQckBancSaldosPor.qckPagina.Print;
      End
      Else
        pGeraExcel;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
      End;
    End;
    pFreeAndNil(frmQckBancSaldosPor);
  End
  Else
  Begin
    pTabelaVazia;
  End;
  btnImprimir.Enabled := True;
end;

procedure TfrmRelBancSaldosPor.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelBancSaldosPor.FormCreate(Sender: TObject);
begin
  inherited;
  shpMultSel.Visible := true;
  blnExcel           := True;
end;

procedure TfrmRelBancSaldosPor.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelBancSaldosPor.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False) Then
  Begin
    fvalidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelBancSaldosPor.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, nil, fRetNomeEmpresaSelec,'da Empresa');
end;

end.

