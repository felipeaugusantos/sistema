unit untImportacaoCustosRegimeTributarioFranquias;

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
  TfrmImportacaoCustosRegimeTributarioFranquias = class(TfrmPai)
    pnlfundo: TPanel;
    lblPath: TLabel;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    rbRecalcularPrecoVenda: TRadioButton;
    rbRecalcularMargem: TRadioButton;
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
    FcpcParams: TParCalculaPrecoCusto;

    const
      cQtdColunas = 17;

    const
      cCodigoEmpresaDescricao = ' CODIGO EMPRESA ';
      cRegimeTributarioDescricao = ' REGIME TRIBUTÁRIO';
      cCodigoItemDescricao = ' CODIGO ITEM';
      cMargem1Descricao = ' MARGEM 1 ';
      cPrecoVenda1Descricao = ' PREÇO VENDA 1';
      cMargem2Descricao = ' MARGEM 2 ';
      cPrecoVenda2Descricao = ' PREÇO VENDA 2';
      cMargem3Descricao = ' MARGEM 3 ';
      cPrecoVenda3Descricao = ' PREÇO VENDA 3';
      cMargem4Descricao = ' MARGEM 4 ';
      cPrecoVenda4Descricao = ' PREÇO VENDA 4';
      cMargem5Descricao = ' MARGEM 5 ';
      cPrecoVenda5Descricao = ' PREÇO VENDA 5';
      cMargem6Descricao = ' MARGEM 6 ';
      cPrecoVenda6Descricao = ' PREÇO VENDA 6';
      cMargem7Descricao = ' MARGEM 7 ';
      cPrecoVenda7Descricao = ' PREÇO VENDA 7';

    const
      cCodigoEmpresa = 'A';
      cRegimeTributario = 'B';
      cCodigoItem = 'C';
      cMargem1 = 'D';
      cPrecoVenda1 = 'E';
      cMargem2 = 'F';
      cPrecoVenda2 = 'G';
      cMargem3 = 'H';
      cPrecoVenda3 = 'I';
      cMargem4 = 'J';
      cPrecoVenda4 = 'K';
      cMargem5 = 'L';
      cPrecoVenda5 = 'M';
      cMargem6 = 'N';
      cPrecoVenda6 = 'O';
      cMargem7 = 'P';
      cPrecoVenda7 = 'Q';

    procedure pPrepararPlanilha;
    procedure pCriarCdsItens;
    function fTemTitulo: boolean;
    procedure pAjustaItensCDS;
    function fValidarArquivo: string;
    procedure pCriarCdsItensNaoEncontrados;
    procedure pCalculaPrecoDeVenda(intLinhaCsv, intTabPre, intOpcao: Integer);
    function fRetComissao(intTabPre: Integer): Double;
    function fRetornaColunaMargemCsv(intTabPre: Integer): string;
    function fRetornaColunaPrecoVendaCsv(intTabPre: Integer): string;
    function fImportar(cxProgresso: TcxProgressBar): Boolean;
    procedure pImportarPlanilha;
    function fRetornaSqlBusca: string;
    procedure pCalculaCusto;
    procedure pAdicionaItemCds(qryBusca: TUniQuery);
    procedure pAdicionarItemCdsCriticas(intLinha: Integer; strMotivo: string);
  public
    { Public declarations }
  end;

  var
  frmImportacaoCustosRegimeTributarioFranquias: TfrmImportacaoCustosRegimeTributarioFranquias;

implementation

{$R *.dfm}

uses untImportacaoCustosRegimeTributarioFranquiasConfirma, untFuncoesConsulta,
  untGravando, untTConfiguracao;

{ TfrmImportacaoCustosRegimeTributarioFranquias }

procedure TfrmImportacaoCustosRegimeTributarioFranquias.btnGravarClick(Sender: TObject);
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

  If (not rbRecalcularMargem.Checked) and (not rbRecalcularPrecoVenda.Checked) Then
  Begin
    fMensagem('AVISO','Necessário escolher o modo de importação!', ['&OK']);
    Exit;
  End;

  TfrmGravando.fExecuta(fImportar, frmGravando, 'Carregando arquivo, aguarde...', False);

  close;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.FormCreate(Sender: TObject);
begin
  inherited;

  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';

  pCriarCdsItensNaoEncontrados;
  pCriarCdsItens;

  FcpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FcpcParams);
  FreeAndNil(cdsItens);
  FreeAndNil(cdsItensNaoEncontrados);
end;

function TfrmImportacaoCustosRegimeTributarioFranquias.fTemTitulo: boolean;
var
  intContador: Integer;
  strCodigoEmpresa: string;
begin
  strCodigoEmpresa := Trim(objValidaExcel.fGetValueCSV(0, cCodigoEmpresa));
  If not fEmptyStr(strCodigoEmpresa) Then
  begin
    Result := False;

    for intContador := 1 to Length(strCodigoEmpresa) do
    begin
      if not CharInSet(strCodigoEmpresa[intContador], ['0','1', '2', '3', '4', '5', '6', '7', '8', '9']) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  Else
    Result := True;
end;

function TfrmImportacaoCustosRegimeTributarioFranquias.fValidarArquivo: string;
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

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pAjustaItensCDS;
var
  intValIni, intContador, intContadorTabelas: Integer;
  strlInformacoes: TStringList;
  strInformacoes: string;
begin
  Try
    Try
      intValIni := IIf(fTemTitulo, 1 , 0);

      strlInformacoes := TStringList.Create;

      For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
      Begin
        If blnArqCsv Then
          If intContador > objValidaExcel.ArquivoCSV.Count Then
            Continue;

        if cdsItens.Locate('ITE_CODEMP;ITE_REGTRI;ITE_CODITE',
          VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intContador, cCodigoEmpresa)), 3),
                              Trim(fUpper(objValidaExcel.fGetValueCSV(intContador, cRegimeTributario))),
                              fStrZero(Trim(objValidaExcel.fGetValueCSV(intContador, cCodigoItem)), 5)]), [loCaseInSensitive]) then
        begin

          strInformacoes := Trim(objValidaExcel.fGetValueCSV(intContador, cCodigoEmpresa)) +
                          Trim(fUpper(objValidaExcel.fGetValueCSV(intContador, cRegimeTributario))) +
                          Trim(objValidaExcel.fGetValueCSV(intContador, cCodigoItem));

          if strlInformacoes.IndexOf(strInformacoes) >= 0 then
          begin
            pAdicionarItemCdsCriticas(intContador, 'Informação duplicada');
            cdsItens.Delete;
            Continue;
          end;

          strlInformacoes.Add(strInformacoes);

          cdsItens.Edit;

          pCalculaCusto;

          For intContadorTabelas := 1 To 7 do
            pCalculaPrecoDeVenda(intContador, intContadorTabelas, IIF(rbRecalcularPrecoVenda.Checked, 1, 2));

          cdsItens.Post;
        end
        else
        begin
          pAdicionarItemCdsCriticas(intContador, 'Item não encontrado');
        end;
      End;
    finally
      FreeAndNil(strlInformacoes);
    end;
  Except
    on E: Exception do
       pMensagensErro(E.Message, '[TfrmImportacaoCustosRegimeTributarioFranquias.pAjustaItensCDS]');
  End;
end;

function TfrmImportacaoCustosRegimeTributarioFranquias.fRetornaSqlBusca: string;
var
  strSql: string;
  intContador: Integer;
begin
  strSql := ('SELECT F.ITE_PRECUS, F.ITE_ICMSAI, F.ITE_IMPFED, F.AUTOINCREM, I.ITE_DESITE, ');
  strSql := strSql + ('F.ITE_CODEMP, F.ITE_REGTRI, F.ITE_CODITE, ');
  For intContador :=  1 To 7 Do
  Begin
    strSql := strSql + ('F.ITE_MARBR' + intContador.tostring + ', ');
    strSql := strSql + ('F.ITE_PREVE' + intContador.tostring + ', ');
    strSql := strSql + ('G.ITE_COMTB' + intContador.tostring + ', ');
  End;

  strSql := strSql + ('G.ITE_PREDOL, G.ITE_PRECOM, G.ITE_DESF01, G.ITE_DESF02, ');
  strSql := strSql + ('G.ITE_DESF03, G.ITE_DESF04, G.ITE_DESF05, G.ITE_DESF06, ');
  strSql := strSql + ('F.ITE_CUSREA, F.ITE_ICMENT, F.ITE_IPIENT, G.ITE_FREENT, ');
  strSql := strSql + ('G.ITE_ACRFIN, F.ITE_SUBSTI, G.ITE_VALFRE, F.ITE_DESADB, ');
  strSql := strSql + ('F.ITE_SUBFED, G.ITE_DESOPE, G.ITE_OUTVAL ');
  strSql := strSql + ('FROM ITERFI F ');
  strSql := strSql + ('INNER JOIN ITEGER G ON G.ITE_CODITE = F.ITE_CODITE AND G.ITE_CODEMP = F.ITE_CODEMP ');
  strSql := strSql + ('INNER JOIN CADITE I ON I.ITE_CODITE = F.ITE_CODITE ');
  strSql := strSql + ('WHERE F.ITE_CODITE = :CODITE ');
  strSql := strSql + ('AND F.ITE_CODEMP =   :CODEMP ');
  strSql := strSql + ('AND F.ITE_REGTRI =   :REGTRI ');

  Result := strSql;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pImportarPlanilha;
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

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoEmpresa))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Código empresa vazio!');
        Continue;
      end
      else
      begin
        if not (StrToIntDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoEmpresa)), 0) > 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Código empresa inválido!');
          Continue;
        end;
      end;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegimeTributario))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Regime tributário vazio!');
        Continue;
      end
      else
      begin
        if Pos(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cRegimeTributario)), 'P_R_S_p_r_s') <= 0 then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Regime tributário inválido!');
          Continue;
        end;
      end;

      If fEmptyStr(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoItem))) Then
      begin
        pAdicionarItemCdsCriticas(intContadorCsv, 'Código item vazio!');
        Continue;
      end
      else
      begin
        if not (StrToIntDef(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoItem)), 0) > 0) then
        begin
          pAdicionarItemCdsCriticas(intContadorCsv, 'Código item inválido!');
          Continue;
        end;
      end;

      if cdsItens.Locate('ITE_CODEMP;ITE_REGTRI;ITE_CODITE',
          VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoEmpresa)), 3),
                              Trim(fUpper(objValidaExcel.fGetValueCSV(intContadorCsv, cRegimeTributario))),
                              fStrZero(Trim(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoItem)), 5)]), [loCaseInSensitive]) then
      begin
        Continue;
      end;

      qryBusca.Close;
      qryBusca.ParamByName('CODITE').AsString := fStrZero(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoItem), 5);
      qryBusca.ParamByName('CODEMP').AsString := fStrZero(objValidaExcel.fGetValueCSV(intContadorCsv, cCodigoEmpresa), 3);
      qryBusca.ParamByName('REGTRI').AsString := fUpper(objValidaExcel.fGetValueCSV(intContadorCsv, cRegimeTributario));
      qryBusca.ExecSQL;

      if qryBusca.RecordCount > 0 then
      begin
        pAdicionaItemCds(qryBusca);
      end;
    end;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pCriarCdsItens;
begin
  cdsItens := TZClient.Create(Self);
  cdsItens.Close;
  cdsItens.FieldDefs.Clear;
  cdsItens.FieldDefs.Add('ITE_CODEMP', ftString, 3);
  cdsItens.FieldDefs.Add('ITE_REGTRI', ftString, 1);
  cdsItens.FieldDefs.Add('ITE_CODITE', ftString, 5);
  cdsItens.FieldDefs.Add('DIF_MARBR1', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE1', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR2', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE2', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR3', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE3', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR4', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE4', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR5', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE5', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR6', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE6', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_MARBR7', ftString, 1);
  cdsItens.FieldDefs.Add('DIF_PREVE7', ftString, 1);
  cdsItens.FieldDefs.Add('ITE_DESITE', ftString, 255);
  cdsItens.FieldDefs.Add('AUTOINCREM', ftString, 30);
  cdsItens.FieldDefs.Add('ITE_PREDOL', ftString, 1);
  cdsItens.FieldDefs.Add('POSSUI_DIFERENCA', ftString, 1);
  cdsItens.FieldDefs.Add('ITE_MARBR1', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE1', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR2', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE2', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR3', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE3', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR4', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE4', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR5', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE5', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR6', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE6', ftFloat);
  cdsItens.FieldDefs.Add('ITE_MARBR7', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PREVE7', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR1', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE1', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR2', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE2', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR3', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE3', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR4', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE4', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR5', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE5', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR6', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE6', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_MARBR7', ftFloat);
  cdsItens.FieldDefs.Add('NOVO_PREVE7', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB1', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB2', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB3', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB4', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB5', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB6', ftFloat);
  cdsItens.FieldDefs.Add('ITE_COMTB7', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESOPE', ftFloat);
  cdsItens.FieldDefs.Add('ITE_OUTVAL', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PRECUS', ftFloat);
  cdsItens.FieldDefs.Add('ITE_ICMSAI', ftFloat);
  cdsItens.FieldDefs.Add('ITE_IMPFED', ftFloat);
  cdsItens.FieldDefs.Add('ITE_PRECOM', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF01', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF02', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF03', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF04', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF05', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESF06', ftFloat);
  cdsItens.FieldDefs.Add('ITE_CUSREA', ftFloat);
  cdsItens.FieldDefs.Add('ITE_ICMENT', ftFloat);
  cdsItens.FieldDefs.Add('ITE_IPIENT', ftFloat);
  cdsItens.FieldDefs.Add('ITE_FREENT', ftFloat);
  cdsItens.FieldDefs.Add('ITE_ACRFIN', ftFloat);
  cdsItens.FieldDefs.Add('ITE_SUBSTI', ftFloat);
  cdsItens.FieldDefs.Add('ITE_VALFRE', ftFloat);
  cdsItens.FieldDefs.Add('ITE_DESADB', ftFloat);
  cdsItens.FieldDefs.Add('ITE_SUBFED', ftFloat);

  cdsItens.CreateDataSet;
  cdsItens.Open;
  cdsItens.EmptyDataSet;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pPrepararPlanilha;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cCodigoEmpresaDescricao, cCodigoEmpresa, 3, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cRegimeTributarioDescricao, cRegimeTributario, 1, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cCodigoItemDescricao, cCodigoItem, 5, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem1Descricao, cMargem1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda1Descricao, cPrecoVenda1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem2Descricao, cMargem2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda2Descricao, cPrecoVenda2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem3Descricao, cMargem3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda3Descricao, cPrecoVenda3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem4Descricao, cMargem4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda4Descricao, cPrecoVenda4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem5Descricao, cMargem5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda5Descricao, cPrecoVenda5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem6Descricao, cMargem6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda6Descricao, cPrecoVenda6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cMargem7Descricao, cMargem7));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cPrecoVenda7Descricao, cPrecoVenda7));
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pCriarCdsItensNaoEncontrados;
begin
  cdsItensNaoEncontrados := TZClient.Create(Self);
  cdsItensNaoEncontrados.Close;
  cdsItensNaoEncontrados.FieldDefs.Clear;
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_CODEMP', ftString, 3);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_REGTRI', ftString, 1);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_CODITE', ftString, 5);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR1', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE1', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR2', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE2', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR3', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE3', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR4', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE4', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR5', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE5', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR6', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE6', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_MARBR7', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('ITE_PREVE7', ftFloat);
  cdsItensNaoEncontrados.FieldDefs.Add('MOTIVO', ftString, 255);
  cdsItensNaoEncontrados.CreateDataSet;
  cdsItensNaoEncontrados.Open;
  cdsItensNaoEncontrados.EmptyDataSet;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pCalculaPrecoDeVenda(intLinhaCsv, intTabPre, intOpcao: Integer);
const
  Epsilon = 0.0000001;
var
  fltValorCsv: Double;
  strCampoOrigemCalculo, strCampoDestinoCalculo: string;
Begin
  if intOpcao = 1 then
  begin
    fltValorCsv := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, fRetornaColunaMargemCsv(intTabPre)), -1);
    strCampoOrigemCalculo := 'NOVO_MARBR' + intTabPre.ToString;
    strCampoDestinoCalculo  := 'NOVO_PREVE' + intTabPre.ToString;
  end
  else
  begin
    fltValorCsv := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinhaCsv, fRetornaColunaPrecoVendaCsv(intTabPre)), -1);
    strCampoOrigemCalculo := 'NOVO_PREVE' + intTabPre.ToString;
    strCampoDestinoCalculo  := 'NOVO_MARBR' + intTabPre.ToString;
  end;

  if (fltValorCsv >= 0) and
      (not SameValue(cdsItens.FieldByName(strCampoOrigemCalculo).AsFloat, fltValorCsv, Epsilon)) then
  begin
    cdsItens.FieldByName(strCampoOrigemCalculo).AsFloat := fltValorCsv;

    cdsItens.FieldByName(strCampoDestinoCalculo).AsFloat := fCalculaPrecoVenda(intOpcao,
                                                                                       cdsItens.FieldByName('ITE_PRECUS').AsFloat +  cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                                                                                       cdsItens.FieldByName('NOVO_PREVE' + intTabPre.ToString).AsFloat,
                                                                                       cdsItens.FieldByName('NOVO_MARBR' + intTabPre.ToString).AsFloat,
                                                                                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                                                                                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                                                                                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                                                                                       fRetComissao(intTabPre));
    cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'S';

    cdsItens.FieldByName('DIF_MARBR' + intTabPre.ToString).AsString := 'S';
    cdsItens.FieldByName('DIF_PREVE' + intTabPre.ToString).AsString := 'S';
  end;
End;

function TfrmImportacaoCustosRegimeTributarioFranquias.fRetComissao(intTabPre: integer): Double;
begin
  Result := 0;
  case intTabPre of
   1: Result := cdsItens.FieldByName('ITE_COMTB1').AsFloat;
   2: Result := cdsItens.FieldByName('ITE_COMTB2').AsFloat;
   3: Result := cdsItens.FieldByName('ITE_COMTB3').AsFloat;
   4: Result := cdsItens.FieldByName('ITE_COMTB4').AsFloat;
   5: Result := cdsItens.FieldByName('ITE_COMTB5').AsFloat;
   6: Result := cdsItens.FieldByName('ITE_COMTB6').AsFloat;
   7: Result := cdsItens.FieldByName('ITE_COMTB7').AsFloat;
  End;
End;

function TfrmImportacaoCustosRegimeTributarioFranquias.fRetornaColunaMargemCsv(intTabPre: Integer): string;
begin
  Result := EmptyStr;

  case intTabPre of
   1: Result := cMargem1;
   2: Result := cMargem2;
   3: Result := cMargem3;
   4: Result := cMargem4;
   5: Result := cMargem5;
   6: Result := cMargem6;
   7: Result := cMargem7;
  End;
End;

function TfrmImportacaoCustosRegimeTributarioFranquias.fRetornaColunaPrecoVendaCsv(intTabPre: Integer): string;
begin
  Result := EmptyStr;

  case intTabPre of
   1: Result := cPrecoVenda1;
   2: Result := cPrecoVenda2;
   3: Result := cPrecoVenda3;
   4: Result := cPrecoVenda4;
   5: Result := cPrecoVenda5;
   6: Result := cPrecoVenda6;
   7: Result := cPrecoVenda7;
  End;
End;

function TfrmImportacaoCustosRegimeTributarioFranquias.fImportar(
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

    frmGravando.lblGravando.Caption := 'Aguarde... Carregando informações cadastradas...';
    Application.ProcessMessages;

    pImportarPlanilha;

    if cdsItens.IsEmpty then
    Begin
      fMensagem('AVISO', 'Não foram encontrados registros!', ['&OK']);
      Exit(False);
    End;

    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    frmGravando.lblGravando.Caption := 'Verificando alterações, aguarde...';
    Application.ProcessMessages;

    pAjustaItensCDS;

    Try
      pCriarFormularios(TfrmImportacaoCustosRegimeTributarioFranquiasConfirma, frmImportacaoCustosRegimeTributarioFranquiasConfirma);
      frmImportacaoCustosRegimeTributarioFranquiasConfirma.ShowModal(cdsItens, cdsItensNaoEncontrados);
    finally
      FreeAndNil(frmImportacaoCustosRegimeTributarioFranquiasConfirma);
    end;
  finally
    FreeAndNil(objValidaExcel);
  end;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pCalculaCusto;
begin
  FcpcParams.curPreCom := cdsItens.FieldByName('ITE_PRECOM').AsFloat;
  FcpcParams.curDesF01 := cdsItens.FieldByName('ITE_DESF01').AsFloat;
  FcpcParams.curDesF02 := cdsItens.FieldByName('ITE_DESF02').AsFloat;
  FcpcParams.curDesF03 := cdsItens.FieldByName('ITE_DESF03').AsFloat;
  FcpcParams.curDesF04 := cdsItens.FieldByName('ITE_DESF04').AsFloat;
  FcpcParams.curDesF05 := cdsItens.FieldByName('ITE_DESF05').AsFloat;
  FcpcParams.curDesF06 := cdsItens.FieldByName('ITE_DESF06').AsFloat;
  FcpcParams.curICMSEnt:= cdsItens.FieldByName('ITE_ICMENT').AsFloat;
  FcpcParams.curIPIEnt := cdsItens.FieldByName('ITE_IPIENT').AsFloat;
  FcpcParams.curFrete  := cdsItens.FieldByName('ITE_FREENT').AsFloat;
  FcpcParams.curAcrFin := cdsItens.FieldByName('ITE_ACRFIN').AsFloat;
  FcpcParams.curSubsti := cdsItens.FieldByName('ITE_SUBSTI').AsFloat;
  FcpcParams.curValFre := cdsItens.FieldByName('ITE_VALFRE').AsFloat;
  FcpcParams.curDesAdb := cdsItens.FieldByName('ITE_DESADB').AsFloat;
  FcpcParams.curSubFed := cdsItens.FieldByName('ITE_SUBFED').AsFloat;
  FcpcParams.curTCIFCu := 0;
  FcpcParams.curTSCust := 0;
  FcpcParams.curDePiCo := 0;
  FcpcParams.curDeICMS := 0;
  FcpcParams.curFatReg := 0;
  cdsItens.FieldByName('ITE_PRECUS').AsFloat := FcpcParams.fCalculaPrecoCusto(cdsItens.FieldByName('ITE_PREDOL').AsString = 'S');
  cdsItens.FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(cdsItens.FieldByName('ITE_PRECUS').AsFloat,
                                                                  cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                                                                  cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                                                                  cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                                                                  cdsItens.FieldByName('ITE_OUTVAL').AsFloat);
End;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pAdicionaItemCds(qryBusca: TUniQuery);
begin
  cdsItens.Insert;
  cdsItens.FieldByName('ITE_CODEMP').AsString := qryBusca.FieldByName('ITE_CODEMP').AsString;
  cdsItens.FieldByName('ITE_REGTRI').AsString := qryBusca.FieldByName('ITE_REGTRI').AsString;
  cdsItens.FieldByName('ITE_CODITE').AsString := qryBusca.FieldByName('ITE_CODITE').AsString;
  cdsItens.FieldByName('ITE_MARBR1').AsFloat := qryBusca.FieldByName('ITE_MARBR1').AsFloat;
  cdsItens.FieldByName('ITE_PREVE1').AsFloat := qryBusca.FieldByName('ITE_PREVE1').AsFloat;
  cdsItens.FieldByName('ITE_MARBR2').AsFloat := qryBusca.FieldByName('ITE_MARBR2').AsFloat;
  cdsItens.FieldByName('ITE_PREVE2').AsFloat := qryBusca.FieldByName('ITE_PREVE2').AsFloat;
  cdsItens.FieldByName('ITE_MARBR3').AsFloat := qryBusca.FieldByName('ITE_MARBR3').AsFloat;
  cdsItens.FieldByName('ITE_PREVE3').AsFloat := qryBusca.FieldByName('ITE_PREVE3').AsFloat;
  cdsItens.FieldByName('ITE_MARBR4').AsFloat := qryBusca.FieldByName('ITE_MARBR4').AsFloat;
  cdsItens.FieldByName('ITE_PREVE4').AsFloat := qryBusca.FieldByName('ITE_PREVE4').AsFloat;
  cdsItens.FieldByName('ITE_MARBR5').AsFloat := qryBusca.FieldByName('ITE_MARBR5').AsFloat;
  cdsItens.FieldByName('ITE_PREVE5').AsFloat := qryBusca.FieldByName('ITE_PREVE5').AsFloat;
  cdsItens.FieldByName('ITE_MARBR6').AsFloat := qryBusca.FieldByName('ITE_MARBR6').AsFloat;
  cdsItens.FieldByName('ITE_PREVE6').AsFloat := qryBusca.FieldByName('ITE_PREVE6').AsFloat;
  cdsItens.FieldByName('ITE_MARBR7').AsFloat := qryBusca.FieldByName('ITE_MARBR7').AsFloat;
  cdsItens.FieldByName('ITE_PREVE7').AsFloat := qryBusca.FieldByName('ITE_PREVE7').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR1').AsFloat := qryBusca.FieldByName('ITE_MARBR1').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE1').AsFloat := qryBusca.FieldByName('ITE_PREVE1').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR2').AsFloat := qryBusca.FieldByName('ITE_MARBR2').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE2').AsFloat := qryBusca.FieldByName('ITE_PREVE2').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR3').AsFloat := qryBusca.FieldByName('ITE_MARBR3').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE3').AsFloat := qryBusca.FieldByName('ITE_PREVE3').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR4').AsFloat := qryBusca.FieldByName('ITE_MARBR4').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE4').AsFloat := qryBusca.FieldByName('ITE_PREVE4').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR5').AsFloat := qryBusca.FieldByName('ITE_MARBR5').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE5').AsFloat := qryBusca.FieldByName('ITE_PREVE5').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR6').AsFloat := qryBusca.FieldByName('ITE_MARBR6').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE6').AsFloat := qryBusca.FieldByName('ITE_PREVE6').AsFloat;
  cdsItens.FieldByName('NOVO_MARBR7').AsFloat := qryBusca.FieldByName('ITE_MARBR7').AsFloat;
  cdsItens.FieldByName('NOVO_PREVE7').AsFloat := qryBusca.FieldByName('ITE_PREVE7').AsFloat;
  cdsItens.FieldByName('DIF_MARBR1').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE1').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR2').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE2').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR3').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE3').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR4').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE4').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR5').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE5').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR6').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE6').AsString := 'N';
  cdsItens.FieldByName('DIF_MARBR7').AsString := 'N';
  cdsItens.FieldByName('DIF_PREVE7').AsString := 'N';
  cdsItens.FieldByName('ITE_PREDOL').AsString := qryBusca.FieldByName('ITE_PREDOL').AsString;
  cdsItens.FieldByName('ITE_COMTB1').AsFloat := qryBusca.FieldByName('ITE_COMTB1').AsFloat;
  cdsItens.FieldByName('ITE_COMTB2').AsFloat := qryBusca.FieldByName('ITE_COMTB2').AsFloat;
  cdsItens.FieldByName('ITE_COMTB3').AsFloat := qryBusca.FieldByName('ITE_COMTB3').AsFloat;
  cdsItens.FieldByName('ITE_COMTB4').AsFloat := qryBusca.FieldByName('ITE_COMTB4').AsFloat;
  cdsItens.FieldByName('ITE_COMTB5').AsFloat := qryBusca.FieldByName('ITE_COMTB5').AsFloat;
  cdsItens.FieldByName('ITE_COMTB6').AsFloat := qryBusca.FieldByName('ITE_COMTB6').AsFloat;
  cdsItens.FieldByName('ITE_COMTB7').AsFloat := qryBusca.FieldByName('ITE_COMTB7').AsFloat;
  cdsItens.FieldByName('ITE_PRECOM').AsFloat := qryBusca.FieldByName('ITE_PRECOM').AsFloat;
  cdsItens.FieldByName('ITE_DESF01').AsFloat := qryBusca.FieldByName('ITE_DESF01').AsFloat;
  cdsItens.FieldByName('ITE_DESF02').AsFloat := qryBusca.FieldByName('ITE_DESF02').AsFloat;
  cdsItens.FieldByName('ITE_DESF03').AsFloat := qryBusca.FieldByName('ITE_DESF03').AsFloat;
  cdsItens.FieldByName('ITE_DESF04').AsFloat := qryBusca.FieldByName('ITE_DESF04').AsFloat;
  cdsItens.FieldByName('ITE_DESF05').AsFloat := qryBusca.FieldByName('ITE_DESF05').AsFloat;
  cdsItens.FieldByName('ITE_DESF06').AsFloat := qryBusca.FieldByName('ITE_DESF06').AsFloat;
  cdsItens.FieldByName('ITE_CUSREA').AsFloat := qryBusca.FieldByName('ITE_CUSREA').AsFloat;
  cdsItens.FieldByName('ITE_ICMENT').AsFloat := qryBusca.FieldByName('ITE_ICMENT').AsFloat;
  cdsItens.FieldByName('ITE_IPIENT').AsFloat := qryBusca.FieldByName('ITE_IPIENT').AsFloat;
  cdsItens.FieldByName('ITE_FREENT').AsFloat := qryBusca.FieldByName('ITE_FREENT').AsFloat;
  cdsItens.FieldByName('ITE_ACRFIN').AsFloat := qryBusca.FieldByName('ITE_ACRFIN').AsFloat;
  cdsItens.FieldByName('ITE_SUBSTI').AsFloat := qryBusca.FieldByName('ITE_SUBSTI').AsFloat;
  cdsItens.FieldByName('ITE_VALFRE').AsFloat := qryBusca.FieldByName('ITE_VALFRE').AsFloat;
  cdsItens.FieldByName('ITE_DESADB').AsFloat := qryBusca.FieldByName('ITE_DESADB').AsFloat;
  cdsItens.FieldByName('ITE_SUBFED').AsFloat := qryBusca.FieldByName('ITE_SUBFED').AsFloat;
  cdsItens.FieldByName('ITE_DESOPE').AsFloat := qryBusca.FieldByName('ITE_DESOPE').AsFloat;
  cdsItens.FieldByName('ITE_OUTVAL').AsFloat := qryBusca.FieldByName('ITE_OUTVAL').AsFloat;
  cdsItens.FieldByName('ITE_PRECUS').AsFloat := qryBusca.FieldByName('ITE_PRECUS').AsFloat;
  cdsItens.FieldByName('ITE_ICMSAI').AsFloat := qryBusca.FieldByName('ITE_ICMSAI').AsFloat;
  cdsItens.FieldByName('ITE_IMPFED').AsFloat := qryBusca.FieldByName('ITE_IMPFED').AsFloat;
  cdsItens.FieldByName('ITE_DESITE').AsString := qryBusca.FieldByName('ITE_DESITE').AsString;
  cdsItens.FieldByName('AUTOINCREM').AsString := qryBusca.FieldByName('AUTOINCREM').AsString;
  cdsItens.FieldByName('POSSUI_DIFERENCA').AsString := 'N';
  cdsItens.Post;
end;

procedure TfrmImportacaoCustosRegimeTributarioFranquias.pAdicionarItemCdsCriticas(intLinha: Integer; strMotivo: string);
begin
  if not (cdsItensNaoEncontrados.Locate('ITE_CODEMP;ITE_REGTRI;ITE_CODITE',
          VarArrayOf([fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cCodigoEmpresa)), 3),
                              Trim(fUpper(objValidaExcel.fGetValueCSV(intLinha, cRegimeTributario))),
                              fStrZero(Trim(objValidaExcel.fGetValueCSV(intLinha, cCodigoItem)), 5)]), [loCaseInSensitive])) then
  begin
    cdsItensNaoEncontrados.Insert;
    cdsItensNaoEncontrados.FieldByName('ITE_CODEMP').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cCodigoEmpresa), 3);
    cdsItensNaoEncontrados.FieldByName('ITE_REGTRI').AsString := fUpper(objValidaExcel.fGetValueCSV(intLinha, cRegimeTributario));
    cdsItensNaoEncontrados.FieldByName('ITE_CODITE').AsString := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cCodigoItem), 5);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR1').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem1);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE1').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda1);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR2').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem2);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE2').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda2);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR3').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem3);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE3').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda3);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR4').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem4);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE4').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda4);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR5').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem5);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE5').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda5);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR6').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem6);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE6').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda6);
    cdsItensNaoEncontrados.FieldByName('ITE_MARBR7').AsString := objValidaExcel.fGetValueCSV(intLinha, cMargem7);
    cdsItensNaoEncontrados.FieldByName('ITE_PREVE7').AsString := objValidaExcel.fGetValueCSV(intLinha, cPrecoVenda7);
    cdsItensNaoEncontrados.FieldByName('MOTIVO').AsString :=  strMotivo;
    cdsItensNaoEncontrados.Post;
  end;
end;

end.
