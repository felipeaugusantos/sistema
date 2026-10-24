unit untIntegraDoctorcred;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, Gauges, MaskEditFocus, Uni, StrUtils,
  EditFocus, UniClientDataSet, DB, UniDataSetProvider, ADODB, ComObj,
  FilenameEditFocus, BitBtnLockedIncrem, Datasnap.Provider, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmIntegraDoctorcred = class(TfrmPai)
    Panel1: TPanel;
    Label17: TLabel;
    barEspecifico: TGauge;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    Label7: TLabel;
    edtDesEmpresa: TEditFocus;
    edtEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    dspGen: TUniDataSetProvider;
    cdsGen: TUniClientDataSet;
    edtOpeDcr: TEditFocus;
    lbl1: TLabel;
    adoConexao: TADOConnection;
    adoQuery: TADOQuery;
    btnConfirma: TBitBtnLocked;
    dirPathArq: TFilenameEditFocus;
    procedure pCarregaEmpresa(var qryCadEmp: TUniQuery);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    intSemaforo: Integer;
    { Private declarations }
  protected
    procedure pRegistrarProgresso(strTexto: String; intInicio, intAtual, intFinal: Integer);
    procedure pGerarVendas(strCodEmp: String);
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function  fFormatValorFloat(fltValor: Double; intCasas: Integer): String; overload;
    function  fFormatValorFloat(strValor: String; intCasas: Integer): String; overload;

    function fIlinkAberto(NomeForm:TForm): Boolean;
    function fAbrirIlink: Boolean;
    function fFecharIlink: Boolean;
    function fAbrirTabela(NomeTabela:TADOQuery): Boolean;
    function fFecharTabela(NomeTabela:TADOQuery): Boolean;
    function fGravarIlink( strNCupom: String; strCartao: String; fltVlrCon: Double = 0.0 ): Boolean;
    function fExisteIFIlink( strNCupom: String ): Boolean;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmIntegraDoctorcred.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEmpresa) Then
    Begin

      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End
    
    Else If (Sender = dirPathArq) Then
    Begin
      If Not FileExists(dirPathArq.Text) Then
      Begin
        fMensagem('', 'O Arquivo BD não existe!', ['OK']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmIntegraDoctorcred.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (InterlockedIncrement(intSemaforo) = 1) Then
  Begin
    If fValidaCampos(mskDtaIni)  And
       fValidaCampos(mskDtaIni)  And
       fValidaCampos(edtEmpresa) And
       fValidaCampos(dirPathArq) Then
    Begin

      Try
        pGerarVendas(edtEmpresa.Text);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      fMensagem('', 'Os registros foram integrados com sucesso!', ['OK']);
      
    End;
    InterlockedDecrement(intSemaforo);
  End
  Else
    InterlockedDecrement(intSemaforo);
end;

procedure TfrmIntegraDoctorcred.pRegistrarProgresso(strTexto: String;
  intInicio, intAtual, intFinal: Integer);
begin
  barEspecifico.MaxValue := intFinal;
  barEspecifico.MinValue := intInicio;
  barEspecifico.Progress := intAtual;
  pnlInfo.Caption        := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmIntegraDoctorcred.pGerarVendas(strCodEmp: String);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    blnOk : Boolean;
begin

  Try
    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  GER_NUMDOC, ';
    strSQL := strSQL + '  CLI_CODDCR, ';
    strSQL := strSQL + '  GER_VLRCON  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP   AND ';
    strSQL := strSQL + '  GER_TIP_FC = "C"       AND ';
    strSQL := strSQL + '  GER_ESPDOC IN ("IF", "IV") AND ';
    strSQL := strSQL + '  CLI_CODDCR IS NOT NULL AND ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');

    strSQL := strSQL + 'ORDER BY      ';
    strSQL := strSQL + '  GER_NUMDOC  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      dspGen.DataSet := qryGen;
      cdsGen.Close;
      cdsGen.SetProvider(dspGen);
      cdsGen.Open;
    End;

    blnOk := True;

    If (cdsGen.RecordCount > 0) Then
    Begin
      fAbrirIlink;

      cdsGen.First;
      While (Not cdsGen.Eof) And blnOk Do
      Begin
        If Not fExisteIFIlink( cdsGen.FieldByName('GER_NUMDOC').AsString ) Then
        Begin
          blnOk := fGravarIlink( cdsGen.FieldByName('GER_NUMDOC').AsString,
                                 cdsGen.FieldByName('CLI_CODDCR').AsString,
                                 cdsGen.FieldByName('GER_VLRCON').AsFloat );
        End;

        pRegistrarProgresso('Vendas - Cupom', 0, cdsGen.RecNo, cdsGen.RecordCount);
        cdsGen.Next;
      End;

      fFecharIlink;
    End;

  Except
    pMensagensErro('Não foi possivel realizar a integração.', '');
  End;

  FreeAndNil(qryGen);
  
end;

procedure TfrmIntegraDoctorcred.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtEmpresa.Text) Then
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
  Begin
    fMensagem('AVISO','Código da Empresa não Encontrado!',['&O K']);
    edtEmpresa.Clear;
    pSetFocus(edtEmpresa);
  End;

end;

procedure TfrmIntegraDoctorcred.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmIntegraDoctorcred.pCarregaEmpresa(var qryCadEmp: TUniQuery);
begin
  If Not (fEmptyStr(edtEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
end;

function TfrmIntegraDoctorcred.fFormatValorFloat(fltValor: Double;
  intCasas: Integer): String;
begin
  Result := AnsiReplaceStr(Format('%.' + IntToStr(intCasas) + 'f', [fltValor]), ',', '.');
end;

function TfrmIntegraDoctorcred.fFormatValorFloat(strValor: String;
  intCasas: Integer): String;
begin
  Result := fFormatValorFloat(fStrToFloat(strValor), intCasas);
end;

function TfrmIntegraDoctorcred.fIlinkAberto(NomeForm:TForm): Boolean;
begin

  If adoConexao.Connected = True Then
  Begin
    Result := True
	End
  Else
  Begin
    Result := False;
    If NomeForm <> Nil Then
		  fMensagem('ATENÇÃO', 'Não há conexão aberta com o banco de dados do Access...', ['&Ok']);
  End;

end;

procedure TfrmIntegraDoctorcred.FormCreate(Sender: TObject);
begin
  inherited;
  dirPathArq.Dialog.Dialog.Filter := 'Access BD|*.mdb';
end;

function TfrmIntegraDoctorcred.fAbrirIlink: Boolean;
begin

  Try

    If fIlinkAberto(Nil) = False Then
    Begin
      adoConexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + dirPathArq.Text +
                                     ';Persist Security Info=False';
      adoConexao.Connected := True;
      Result := True;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'Você já está conectado com o banco de dados Access!', ['&Ok']);
      Result := True;
    End;

  Except

 		On E : EOleSysError Do
 		Begin
  	  fMensagem('ATENÇÃO', E.Message + ' Nr erro ' + IntToStr(E.ErrorCode), ['&Ok']);
		  Result := False;
	  End;

  End;

end;

function TfrmIntegraDoctorcred.fFecharIlink: Boolean;
begin

  Try

    If fIlinkAberto(Nil) = True Then
      adoConexao.Connected := False;
    Result := True;

  Except

    On E : EOleSysError Do
 		Begin
 		  Result := False;
      fMensagem('ATENÇÃO', E.Message + ' Nr Erro ' + IntToStr(E.ErrorCode), ['&Ok']);
    End;

  End;

end;

function TfrmIntegraDoctorcred.fAbrirTabela(NomeTabela:TADOQuery): Boolean;
begin

	Try

   	If NomeTabela.Active = False Then NomeTabela.Open;
    Result := True;

  Except

    On E : EDatabaseError Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fAbrirTabela]');
    End;

	End;

end;

function TfrmIntegraDoctorcred.fFecharTabela(NomeTabela:TADOQuery): Boolean;
begin

	Try

   	If NomeTabela.Active = True Then NomeTabela.Close;
    Result := True;

  Except

    On E : EDatabaseError Do
    Begin
			Result := False;
      pMensagensErro(E.Message,'[fFecharTabela]');
    End;

  End;

end;

function TfrmIntegraDoctorcred.fGravarIlink( strNCupom: String; strCartao: String; fltVlrCon: Double = 0.0 ): Boolean;
Var
  strSQL   : String;
Begin
  
  Try
    Try

      With adoQuery Do
      Begin

        Close;

        strSQL := '';
        strSQL := strSQL + 'INSERT INTO ILINK (';
        strSQL := strSQL + ' CPF,              ';
        strSQL := strSQL + ' N_CUPOM,          ';
        strSQL := strSQL + ' N_CARTAO,         ';
        strSQL := strSQL + ' VALOR,            ';
        strSQL := strSQL + ' CODIGO_OPERADOR,  ';
        strSQL := strSQL + ' CODIGO_TERMINAL   ';
        strSQL := strSQL + ') VALUES ( ';
        strSQL := strSQL + ' :NROCPF,  ';
        strSQL := strSQL + ' :NCUPOM,  ';
        strSQL := strSQL + ' :CARTAO,  ';
        strSQL := strSQL + ' :VLRCON,  ';
        strSQL := strSQL + ' :CODOPE,  ';
        strSQL := strSQL + ' :CODTML   ';
        strSQL := strSQL + ' )';

        Sql.Clear;
        Sql.Add( strSQL );

        Parameters[ 0 ].Value := '';
        Parameters[ 1 ].Value := fStrZero(strNCupom, 16);
        Parameters[ 2 ].Value := strCartao;
        Parameters[ 3 ].Value := fltVlrCon;
        Parameters[ 4 ].Value := StrToInt64(edtOpeDcr.Text);
        Parameters[ 5 ].Value := 1;

        ExecSQL;

      End;

    Except On E : EOleSysError Do
      Begin
        fMensagem('ATENÇÃO', Copy( E.Message + ' [fGravarIlink]', 1, 254 ), ['&Ok']);
      End;
    End;
  Finally
    Result := True;
  End;

End;

function TfrmIntegraDoctorcred.fExisteIFIlink(strNCupom: String): Boolean;
	Var
    strSQL: String;
Begin

  Try

    With adoQuery Do
    Begin

      Close;

      strSQL := '';
      strSQL := strSQL + 'SELECT    ';
      strSQL := strSQL + ' COUNT(*) AS QTDE ';
      strSQL := strSQL + 'FROM      ';
      strSQL := strSQL + ' ILINK    ';
      strSQL := strSQL + 'WHERE     ';
      strSQL := strSQL + 'N_CUPOM = :NUMDOC ';

      Sql.Clear;
      Sql.Add( strSQL );

      Parameters[ 0 ].Value := fStrZero(strNCupom, 16);
      Open;

      Result := FieldByName('QTDE').AsInteger > 0;

    End;

  Except

    On E : EOleSysError Do
    Begin
      fMensagem('ATENÇÃO', Copy( E.Message + ' [fExisteIFIlink]', 1, 254 ), ['&Ok']);
      Result := False;
    End;

  End;

end;

end.

