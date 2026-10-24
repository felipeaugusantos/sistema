unit untImportacaoCadRegioesDesconto;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math, untTypesSistema,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untParCalculaPrecoCusto, Grids, untTValidaExcel, Datasnap.DBClient,
  EditFocus, CxProgressBar, frxDBSet;

type
  TfrmImportacaoCadRegioesDesconto = class(TfrmPai)
    pnlfundo: TPanel;
    lblPath: TLabel;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    pnlOpcoesImportacao: TPanel;

    procedure btnGravarClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    blnArqCsv: Boolean;
    cdsItens, cdsItensNaoEncontrados : TZClient;
    objValidaExcel : TValidadorExcel;

    const
      cQtdColunas = 4;

    const
      cRegiaoDescricao = 'REGIÃO';
      cFornecedorDescricao = 'FORNECEDOR';
      cDescontoDescricao = 'DESCONTO';
      cComissaoDescricao = 'COMISSÃO';

    const
      cRegiao = 'A';
      cFornecedor = 'B';
      cDesconto = 'C';
      cComissao = 'D';

    procedure pPrepararPlanilha;
    procedure pCriarCdsItens;
    function fTemTitulo: boolean;
    procedure pAjustaItemCDS(intLinhaCsv: Integer);
    function fValidarArquivo: string;
    procedure pCriarCdsItensNaoEncontrados;
    function fImportar(cxProgresso: TcxProgressBar): Boolean;
    procedure pImportarPlanilha;
    function fRetornaSqlBusca: string;
    procedure pAdicionaItemCds(qryBusca: TUniQuery); overload;
    procedure pAdicionaItemCds(intLinha: Integer); overload;
    procedure pAdicionarItemCdsCriticas(intLinha: Integer; strMotivo: string);
  public
    { Public declarations }
  end;

  var
  frmImportacaoCadRegioesDesconto: TfrmImportacaoCadRegioesDesconto;

implementation

{$R *.dfm}

uses untImportacaoCadRegioesDescontoConfirma, untFuncoesConsulta,
  untGravando, untTConfiguracao;

{ TfrmImportacaoCadRegioesDesconto }

procedure TfrmImportacaoCadRegioesDesconto.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    fMensagem('AVISO','Necessário escolher o arquivo!', ['&OK']);
    Exit;
  End;

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&OK']);
    Exit;
  End;

  TfrmGravando.fExecuta(fImportar, frmGravando, 'Carregando arquivo, aguarde...', False);

  close;
end;

procedure TfrmImportacaoCadRegioesDesconto.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoCadRegioesDesconto.FormCreate(Sender: TObject);
begin
  inherited;

  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';

  pCriarCdsItensNaoEncontrados;
  pCriarCdsItens;
end;

procedure TfrmImportacaoCadRegioesDesconto.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsItens);
  FreeAndNil(cdsItensNaoEncontrados);
end;

function TfrmImportacaoCadRegioesDesconto.fTemTitulo: boolean;
var
  intContador: Integer;
  strRegiao: string;
begin
  strRegiao := Trim(objValidaExcel.fGetValueCSV(0, cRegiao));
  If not fEmptyStr(strRegiao) Then
  Begin
    Result := False;

    for intContador := 1 to Length(strRegiao) do
    begin
      if not CharInSet(strRegiao[intContador], ['0','1', '2', '3', '4', '5', '6', '7', '8', '9']) then
      begin
        Result := True;
        Exit;
      end;
    end;
  End
  Else
  Begin
    Result := True;
  End;
end;

function TfrmImportacaoCadRegioesDesconto.fValidarArquivo: string;
var
  intValIni: Integer;
begin
  intValIni := IIf(fTemTitulo, 1 , 0);

  if not (objValidaExcel.ArquivoCSV.Count > intValIni) then
  begin
    Result := 'Não foram encontrados códigos válidos!';
    Exit;
  end;
end;

procedure TfrmImportacaoCadRegioesDesconto.pAjustaItemCDS(intLinhaCsv: Integer);
const
  Epsilon = 0.0000001;
var
  strlInformacoes: TStringList;
  strInformacoes: string;
begin
  Try
    Try
      strlInformacoes := TStringList.Create;

      if cdsItens.Locate('RDS_CODREG;RDS_CODFOR',
          VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinhaCsv, cRegiao)), 5),
                      fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinhaCsv, cFornecedor)), 8)
                      ]), [loCaseInSensitive]) then
      begin
        strInformacoes := Trim(objValidaExcel.fGetValueCSV(intLinhaCsv, cRegiao)) +
                          Trim(objValidaExcel.fGetValueCSV(intLinhaCsv, cFornecedor));

        if strlInformacoes.IndexOf(strInformacoes) >= 0 then
        begin
          pAdicionarItemCdsCriticas(intLinhaCsv, 'Informação duplicada');
          cdsItens.Delete;
          Exit;
        end;

        strlInformacoes.Add(strInformacoes);

        cdsItens.Edit;

        if (StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cComissao), -1) >= 0) and
              (not SameValue(cdsItens.FieldByName('RDS_PERCOM').AsFloat, StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cComissao), -1), Epsilon)) then
        begin
          cdsItens.FieldByName('NOVO_PERCOM').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cComissao), -1);
          cdsItens.FieldByName('DIF_PERCOM').AsString := 'S';
          cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
        end;

        if (StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cDesconto), -1) >= 0) and
              (not SameValue(cdsItens.FieldByName('RDS_PERDES').AsFloat, StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cDesconto), -1), Epsilon)) then
        begin
          cdsItens.FieldByName('NOVO_PERDES').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, cDesconto), -1);
          cdsItens.FieldByName('DIF_PERDES').AsString := 'S';
          cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
        end;

        cdsItens.Post;
      end
      else
      begin
        pAdicionarItemCdsCriticas(intLinhaCsv, 'Item não encontrado');
      end;
    finally
      FreeAndNil(strlInformacoes);
    end;
  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportacaoCadRegioesDesconto.pAjustaItensCDS]');
  End;
end;

function TfrmImportacaoCadRegioesDesconto.fRetornaSqlBusca: string;
begin
  Result := '';
  Result := Result + ' SELECT REG_DESREG, FOR_NOMFOR, RDS_CODEMP, RDS_PERDES, ';
  Result := Result + ' RDS_PERCOM, RDS_CODFOR, RDS_CODREG, REGDES.AUTOINCREM  ';
  Result := Result + ' FROM REGDES ';
  Result := Result + ' JOIN CADREG ON REG_CODREG = RDS_CODREG ';
  Result := Result + ' JOIN CADFOR ON FOR_CODFOR = RDS_CODFOR ';
  Result := Result + ' WHERE RDS_CODREG = :CODREG AND ';
  Result := Result + ' RDS_CODFOR = :CODFOR AND RDS_CODEMP = :CODEMP';
end;

procedure TfrmImportacaoCadRegioesDesconto.pImportarPlanilha;
var
  intValIni, intContadorCsv: Integer;
  qryBusca: TUniQuery;
begin
  intValIni := IIf(fTemTitulo, 1 , 0);

  qryBusca := fCriaQuery;
  qryBusca.SQL.Text := fRetornaSqlBusca;

  Try
    For intContadorCsv := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      If blnArqCsv Then
        If intContadorCsv > objValidaExcel.ArquivoCSV.Count Then
          Continue;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegiao))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Código região vazio!');
        Continue;
      end
      else
      begin
        if not (StrToIntDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegiao)), 0) > 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Código região inválido!');
          Continue;
        end
        else
        begin
          if fEmptyStr(fRetNomRegiao(fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegiao)), 5))) then
          begin
            pAdicionarItemCdsCriticas(intContadorCsv, 'Código região não encontrado!');
            Continue;
          end
        end;
      end;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cFornecedor))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Código fornecedor vazio!');
        Continue;
      end
      else
      begin
        if not (StrToIntDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cFornecedor)), 0) > 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Código fornecedor inválido!');
          Continue;
        end
        else
        begin
          if fEmptyStr(fRetNomFornecedor(fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cFornecedor)), 8))) then
          begin
            pAdicionarItemCdsCriticas(intContadorCsv, 'Código fornecedor não encontrado!');
            Continue;
          end
        end;
      end;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cDesconto))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Desconto vazio!');
        Continue;
      end
      else
      begin
        if not (StrToFloatDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cDesconto)), -1) >= 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Desconto inválido!');
          Continue;
        end
        else
        begin
          if StrToFloatDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cDesconto)), 0) > 100 then
          begin
            pAdicionarItemCdsCriticas(intContadorCsv, 'Desconto inválido, o valor deve ser menor que 100!');
            Continue;
          end;
        end;
      end;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cComissao))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Comissão vazia!');
        Continue;
      end
      else
      begin
        if not (StrToFloatDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cComissao)), -1) >= 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Comissão inválida!');
          Continue;
        end
        else
        begin
          if StrToFloatDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cComissao)), 0) > 100 then
          begin
            pAdicionarItemCdsCriticas(intContadorCsv, 'Comissão inválida, o valor deve ser menor que 100!');
            Continue;
          end;
        end;
      end;

      if cdsItens.Locate('RDS_CODREG;RDS_CODFOR',
          VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegiao)), 5),
                      fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cFornecedor)), 8)
                      ]), [loCaseInSensitive]) then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Informação duplicada');
        cdsItens.Delete;
        Continue;
      end;

      qryBusca.Close;
      qryBusca.ParamByName('CODREG').AsString := fStrZero(objValidaExcel.fGetValueCSV(intContadorCsv, cRegiao), 5);
      qryBusca.ParamByName('CODFOR').AsString := fStrZero(objValidaExcel.fGetValueCSV(intContadorCsv, cFornecedor), 8);
      qryBusca.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryBusca.ExecSQL;

      if qryBusca.RecordCount > 0 then
      begin
        pAdicionaItemCds(qryBusca);

        pAjustaItemCDS(intContadorCsv);
      end
      else
      begin
        pAdicionaItemCds(intContadorCsv);
      end;
    end;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TfrmImportacaoCadRegioesDesconto.pCriarCdsItens;
begin
  cdsItens := TZClient.Create(Self);
  cdsItens.Close;
  cdsItens.FieldDefs.Clear;
  cdsItens.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsItens.FieldDefs.Add('POSSUI_DIFERENCA', ftString, 1);
  cdsItens.FieldDefs.Add('FOR_NOMFOR', ftString, 255);
  cdsItens.FieldDefs.Add('REG_DESREG', ftString, 255);
  cdsItens.FieldDefs.Add('RDS_CODEMP', ftString, 3);
  cdsItens.FieldDefs.Add('RDS_CODFOR', ftString, 8);
  cdsItens.FieldDefs.Add('RDS_CODREG', ftString, 5);
  cdsItens.FieldDefs.Add('RDS_PERCOM', ftFloat);
  cdsItens.FieldDefs.Add('RDS_PERDES', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PERCOM', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PERDES', ftFloat);
  cdsItens.FieldDefs.Add('DIF_PERCOM', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PERDES', ftString, 1);
  cdsItens.CreateDataSet;
  cdsItens.Open;
  cdsItens.EmptyDataSet;
end;

procedure TfrmImportacaoCadRegioesDesconto.pPrepararPlanilha;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cRegiaoDescricao, cRegiao, 5, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cFornecedorDescricao, cFornecedor, 8, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescontoDescricao, cDesconto));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cComissaoDescricao, cComissao));
end;

procedure TfrmImportacaoCadRegioesDesconto.pCriarCdsItensNaoEncontrados;
begin
  cdsItensNaoEncontrados := TZClient.Create(Self);
  cdsItensNaoEncontrados.Close;
  cdsItensNaoEncontrados.FieldDefs.Clear;
  cdsItensNaoEncontrados.FieldDefs.Add('MOTIVO', ftString, 255);
  cdsItensNaoEncontrados.FieldDefs.Add('RDS_CODFOR', ftString, 8);
  cdsItensNaoEncontrados.FieldDefs.Add('RDS_CODREG', ftString, 5);
  cdsItensNaoEncontrados.FieldDefs.Add('RDS_PERCOM', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('RDS_PERDES', ftFloat);
  cdsItensNaoEncontrados.CreateDataSet;
  cdsItensNaoEncontrados.Open;
  cdsItensNaoEncontrados.EmptyDataSet;
end;

function TfrmImportacaoCadRegioesDesconto.fImportar(
  cxProgresso: TcxProgressBar): Boolean;
Var
  strMensagemValidacao: string;
begin
  Result := True;

  objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, '', '', 0);

  try
    pPrepararPlanilha;

    strMensagemValidacao := fValidarArquivo;

    If Not (fEmptyStr(strMensagemValidacao)) Then
    Begin
      fMensagem('AVISO', 'Arquivo inválido' + #13 + strMensagemValidacao, ['&OK']);
      Exit(False);
    End;

    blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

    frmGravando.lblGravando.Caption := 'Aguarde... Carregando informações...';
    Application.ProcessMessages;

    pImportarPlanilha;

    if cdsItens.IsEmpty then
    Begin
      fMensagem('AVISO', 'Não foram encontrados registros válidos para importação!', ['&OK']);
      Exit(False);
    End;

    Try
      pCriarFormularios(TfrmImportacaoCadRegioesDescontoConfirma, frmImportacaoCadRegioesDescontoConfirma);
      frmImportacaoCadRegioesDescontoConfirma.ShowModal(cdsItens, cdsItensNaoEncontrados);
    finally
      FreeAndNil(frmImportacaoCadRegioesDescontoConfirma);
    end;
  finally
    FreeAndNil(objValidaExcel);
  end;
end;

procedure TfrmImportacaoCadRegioesDesconto.pAdicionaItemCds(qryBusca: TUniQuery);
begin
  if not (cdsItensNaoEncontrados.Locate('RDS_CODFOR;RDS_CODREG',
            VarArrayOf([qryBusca.FieldByName('RDS_CODFOR').AsString, qryBusca.FieldByName('RDS_CODREG').AsString]),
            [loCaseInSensitive])) then
  begin
    cdsItens.Insert;
    cdsItens.FieldByName('AUTOINCREM').AsString := qryBusca.FieldByName('AUTOINCREM').AsString;
    cdsItens.FieldByName('FOR_NOMFOR').AsString := qryBusca.FieldByName('FOR_NOMFOR').AsString;
    cdsItens.FieldByName('REG_DESREG').AsString := qryBusca.FieldByName('REG_DESREG').AsString;
    cdsItens.FieldByName('RDS_CODEMP').AsString := qryBusca.FieldByName('RDS_CODEMP').AsString;
    cdsItens.FieldByName('RDS_CODFOR').AsString := qryBusca.FieldByName('RDS_CODFOR').AsString;
    cdsItens.FieldByName('RDS_CODREG').AsString := qryBusca.FieldByName('RDS_CODREG').AsString;
    cdsItens.FieldByName('RDS_PERCOM').AsFloat := qryBusca.FieldByName('RDS_PERCOM').AsFloat;
    cdsItens.FieldByName('RDS_PERDES').AsFloat := qryBusca.FieldByName('RDS_PERDES').AsFloat;
    cdsItens.FieldByName('NOVO_PERCOM').AsFloat := qryBusca.FieldByName('RDS_PERCOM').AsFloat;
    cdsItens.FieldByName('NOVO_PERDES').AsFloat := qryBusca.FieldByName('RDS_PERDES').AsFloat;
    cdsItens.FieldByName('DIF_PERCOM').AsString := 'N';
    cdsItens.FieldByName('DIF_PERDES').AsString := 'N';
    cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'N';
    cdsItens.Post;
  end;
end;

procedure TfrmImportacaoCadRegioesDesconto.pAdicionaItemCds(intLinha: Integer);
begin
  if not (cdsItensNaoEncontrados.Locate('RDS_CODFOR;RDS_CODREG',
            VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cFornecedor)), 8),
                        fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cRegiao)), 5)
                        ]), [loCaseInSensitive])) then
  begin
    cdsItens.Insert;
    cdsItens.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(fStrZero(objValidaExcel.fGetValueCSV(intLinha, cFornecedor), 8));
    cdsItens.FieldByName('REG_DESREG').AsString := fRetNomRegiao(fStrZero(objValidaExcel.fGetValueCSV(intLinha, cRegiao), 5));
    cdsItens.FieldByName('RDS_CODEMP').AsString := VS_strCodEmp;
    cdsItens.FieldByName('RDS_CODFOR').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cFornecedor), 8);
    cdsItens.FieldByName('RDS_CODREG').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cRegiao), 5);
    cdsItens.FieldByName('NOVO_PERCOM').AsString := objValidaExcel.fGetValueCSV(intLinha, cComissao);
    cdsItens.FieldByName('NOVO_PERDES').AsString := objValidaExcel.fGetValueCSV(intLinha, cDesconto);
    cdsItens.FieldByName('DIF_PERCOM').AsString := 'N';
    cdsItens.FieldByName('DIF_PERDES').AsString := 'N';
    cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'S';
    cdsItens.Post;
  end;
end;

procedure TfrmImportacaoCadRegioesDesconto.pAdicionarItemCdsCriticas(intLinha: Integer; strMotivo: string);
begin
  if not (cdsItensNaoEncontrados.Locate('RDS_CODFOR;RDS_CODREG',
            VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cFornecedor)), 8),
                        fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cRegiao)), 5)
                        ]), [loCaseInSensitive])) then
  begin
    cdsItensNaoEncontrados.Insert;
    cdsItensNaoEncontrados.FieldByName('RDS_CODFOR').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cFornecedor), 8);
    cdsItensNaoEncontrados.FieldByName('RDS_CODREG').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cRegiao), 5);
    cdsItensNaoEncontrados.FieldByName('RDS_PERCOM').AsString := objValidaExcel.fGetValueCSV(intLinha, cComissao);
    cdsItensNaoEncontrados.FieldByName('RDS_PERDES').AsString := objValidaExcel.fGetValueCSV(intLinha, cDesconto);
    cdsItensNaoEncontrados.FieldByName('MOTIVO').AsString :=  strMotivo;
    cdsItensNaoEncontrados.Post;
  end;
end;

end.
