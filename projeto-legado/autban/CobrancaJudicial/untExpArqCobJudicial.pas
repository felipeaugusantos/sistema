unit untExpArqCobJudicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, StrUtils, untGravando,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, Uni, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxProgressBar,
  cxButtonEdit, DirectoryEditFocus, EditFocus, Data.DB, Datasnap.DBClient,
  FilenameEditFocus, Vcl.CustomizeDlg, UniClientDataSet;

type
  TfrmExpArqCobJudicial = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    pnlTopo: TPanel;
    cdsCliDup: TUniClientDataSet;
    cdsCliDupCODCLI: TStringField;
    cdsCliDupNUMDUP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetornaTelefoneCliente(intTipo: Integer;strFone01,strFone02,strFone03: String): String;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqCobJudicial: TfrmExpArqCobJudicial;

implementation

uses untFuncoesSimples, untFuncoes, untConsultas;

{$R *.dfm}

procedure TfrmExpArqCobJudicial.btnGerarClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao       := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
end;

procedure TfrmExpArqCobJudicial.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqCobJudicial.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmExpArqCobJudicial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryCadPor) Then
    FreeAndNil(qryCadPor);
end;

procedure TfrmExpArqCobJudicial.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  cdsCliDup.CreateDataSet;
end;

procedure TfrmExpArqCobJudicial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

function TfrmExpArqCobJudicial.fRetornaTelefoneCliente(intTipo: Integer;
  strFone01, strFone02, strFone03: String): String;
Type
  TFone = record
    strFone: String;
  End;
var
  ArrFone: array of TFone;
  intCont: Integer;

begin
  Result := '';

  SetLength(ArrFone, 3);

  ArrFone[0].strFone := strFone01;
  ArrFone[1].strFone := strFone02;
  ArrFone[2].strFone := strFone03;

  For intCont := 0 To Length(ArrFone) - 1 Do
  Begin
    If Not fEmptyStr(ArrFone[intCont].strFone) And fEmptyStr(Result) Then
      Result := ArrFone[intCont].strFone;
  End;

  If Not fEmptyStr(Result) Then
  Begin
    If intTipo = 1 Then // Tipo = 1 (Retorna DDD)
    Begin
      If Length(Result) = 11 Then
        Result := LeftStr(Result, 2);
    End
    Else // Tipo = 1 (Retorna Telefone)
    Begin
      Result := RightStr(Result, 8);
    End;
  End;
end;

function TfrmExpArqCobJudicial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmExpArqCobJudicial.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
Var
  svdCsv: TSaveDialog;
  strLinha,
  strNomArq: String;
  stlCsv: TStringList;
  strSQL      : String;
  strNomEmp   : String;
  strDtaVen   : String;
  strDtaEmi   : String;
  strCgcEmp   : String;
  strCgcCli   : String;
  qryRemessa  : TUniquery;
  strDDDCli   : String;
  strFonCli   : String;

  procedure pStepStatusGravacao;
  Begin
    If Assigned(cxProgress) Then
    Begin
      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
  End;

  procedure pInfoStatusGravacao(strInformacao: String);
  Begin
    If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
    Begin
      TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
      Application.ProcessMessages;
    End;
  End;
begin
  Result := True;

  pInfoStatusGravacao('Gerando arquivo CSV. Aguarde...');

{  cxProgress.Position := 0;
  cxProgress.Properties.Max := qryConsulta.RecordCount;}

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';
  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;


  Try
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADEMP ';
    strSQL := strSQL + 'WHERE EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  qryRemessa := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.CBI_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  B.CBI_PARCEL AS PARCEL, ';
  strSQL := strSQL + '  B.CBI_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  B.*, ';
  strSQL := strSQL + '  CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  C.CLI_CODCLI, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  C.CLI_FONE01, ';
  strSQL := strSQL + '  C.CLI_FONE02, ';
  strSQL := strSQL + '  C.CLI_CELULA, ';
  strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO,  ';
  strSQL := strSQL + '  D.OPE_NOMOPE, ';
  strSQL := strSQL + '  D.OPE_FONE01  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCBI B ';
  strSQL := strSQL + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADOPE D ON D.OPE_CODOPE = B.CBI_CODOEC ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  CBI_CODBCO = :CODBCO ';

  If (Not fEmptyStr(edtCodPor.Text)) Then
    strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

  With qryRemessa Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := 'GLO';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      ParamByName('CODPOR').AsString := edtCodPor.Text;

    Open;
  End;

  strCgcEmp := Trim(strCgcEmp);
  strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
  strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
  strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

  If Not qryRemessa.IsEmpty Then
  Begin
    cdsCliDup.Open;

    If svdCsv.Execute Then
    Begin
      strNomArq := svdCsv.FileName;

      If Not fEmptyStr(strNomArq) Then
      Begin
        stlCsv := TStringList.Create;
        stlCsv.Clear;

        With qryRemessa Do
        Begin
          First;

          strLinha := 'CNPJ EMPRESA CREDORA;RAZÃO SOCIAL EMPRESA CREDORA;CNPJ CLIENTE;NOME CLIENTE;' +
                      'ENDEREÇO COBRANÇA;BAIRRO;CIDADE;UF;CEP;DDD1;TELEFONE1;ESPÉCIE DO TÍTULO;NÚMERO DO TÍTULO;' +
                      'NÚMERO DA PARCELA;EMISSÃO;VENCIMENTO;VALOR;TAXA DE PROTESTO;OBSERVAÇÕES;CÓD. IDENTIFICADOR DEVEDOR;'+
                      'NOME DO REPRESENTANTE QUE EFETUOU A VENDA;DDD E FONE PARA CONTATO COM O REPRESENTANTE;EMAIL';

          stlCsv.Add(strLinha);

          While Not Eof Do
          Begin
            strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
            strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
            strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
            strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) + '/' +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) + '/' +
                         FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

            strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) + '/' +
                         FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) + '/' +
                         FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

            strDDDCli := fRetornaTelefoneCliente(1,FieldByName('CLI_FONE01').AsString,FieldByName('CLI_FONE02').AsString,FieldByName('CLI_CELULA').AsString);
            strFonCli := fRetornaTelefoneCliente(2,FieldByName('CLI_FONE01').AsString,FieldByName('CLI_FONE02').AsString,FieldByName('CLI_CELULA').AsString);

            strLinha := strCgcEmp + ';' +                                                 //
                        strNomEmp + ';' +                                                 //
                        strCgcCli + ';' +                                                 //
                        FieldByName('NOMCLI').AsString + ';' +                            //
                        FieldByName('ENDERE').AsString + ';' +                            //
                        FieldByName('BAIRRO').AsString + ';' +                            //
                        FieldByName('CIDADE').AsString + ';' +                            //
                        FieldByName('ESTADO').AsString + ';' +                            //
                        FieldByName('C_E_P_').AsString + ';' +                            //
                        strDDDCli + ';' +                                                 //
                        strFonCli + ';' +                                                 //
                        FieldByName('ESPDOC').AsString + ';' +                            //
                        FieldByName('NUMDUP').AsString + ';' +                            //
                        FieldByName('PARCEL').AsString + ';' +                            //
                        strDtaEmi + ';' +                                                 //
                        strDtaVen + ';' +                                                 //
                        FormatFloat('#,##0.00',FieldByName('CBI_VALDUP').AsFloat) + ';' + //
                        '' + ';' +                                                        //
                        '' + ';' +                                                        //
                        '' + ';' +                                                        //
                        '' + ';' +                                                        //
                        '' + ';' +                                                        //
                        '';                                                               //

            stlCsv.Add(strLinha);
            pStepStatusGravacao;
            Next;
          End;
        end;

        stlCsv.SaveToFile(strNomArq);
        FreeAndNil(stlCsv);
        fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);

        {********************************************************}
        {* EXCLUI AS DUPLICATAS SELECIONADAS DA TABELA AUXILIAR *}
        {********************************************************}
        strSQL := '';
        strSQL := strSQL + 'DELETE FROM ';
        strSQL := strSQL + '  CADCBI ';
        strSQL := strSQL + 'WHERE CBI_CODBCO = :CODBCO ';

        If (Not fEmptyStr(edtCodPor.Text)) Then
          strSQL := strSQL + ' AND CBI_CODPOR = :CODPOR ';

        With qryRemessa Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBCO').AsString := 'GLO';

          If (Not fEmptyStr(edtCodPor.Text)) Then
            ParamByName('CODPOR').AsString := edtCodPor.Text;

          ExecSQL;
          Close;
        End;
      end;
    end;
  End
  Else
  Begin
    fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
  End;
END;

end.
