unit untRelFiscRestituicaoIcms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, Vcl.ExtCtrls, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  QColorLabel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, Uni,
  System.Generics.Defaults, System.Generics.Collections, Data.DB, UniClientDataSet,
  Datasnap.DBClient, Vcl.ComCtrls;

type
  TReImpressaoRelatorio = class
  private
    FCdsDados: TUniClientDataSet;
    FDataExportacao: TDateTime;
    FCodEmp: String;

    procedure pInicializaDados;
    procedure pCarregaDados;
  public
    function fReImpressao(cdsAux: TUniClientDataSet; dtaExportacao: TDateTime; strCodEmp: String): boolean;
  end;

type
  //dados tabela: CAT_158
  TItemNotaValidacao = class
    strAutoIncrem: String;
    strSeqGer: String;
    fltQuantidadeUtilizada: Double;
    fltQuantidadeTotal: Double;
  end;

type
  TfrmRelFiscRestituicaoIcms = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label3: TLabel;
    lblCodCla: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDocumento: TEditFocus;
    edtCodClaFis: TEditFocus;
    edtDesClaFis: TEditFocus;
    frxDBDataset1: TfrxDBDataset;
    frxRelatorioJ: TfrxReport;
    cdsRestituicaoIcmsSt: TUniClientDataSet;
    cdsRestituicaoIcmsStPRODUTO: TStringField;
    cdsRestituicaoIcmsStFORNECEDOR: TStringField;
    cdsRestituicaoIcmsStDOCUMENTO_E: TStringField;
    cdsRestituicaoIcmsStUF_FORNECEDOR: TStringField;
    cdsRestituicaoIcmsStVLR_E: TFloatField;
    cdsRestituicaoIcmsStBC_ST_UNIT_E: TFloatField;
    cdsRestituicaoIcmsStQTD_E: TFloatField;
    cdsRestituicaoIcmsStBC_ST_TOTAL_E: TFloatField;
    cdsRestituicaoIcmsStALIQ_INTERNA_E: TFloatField;
    cdsRestituicaoIcmsStCRED_ST_E: TFloatField;
    cdsRestituicaoIcmsStCRED_ICM_E: TFloatField;
    cdsRestituicaoIcmsStQTD_V: TFloatField;
    cdsRestituicaoIcmsStDOCUMENTO_V: TStringField;
    pgbProgresso: TProgressBar;
    btnDeletarPeriodo: TBitBtnLocked;
    cdsRestituicaoIcmsStINCCOM: TStringField;
    cdsRestituicaoIcmsStQTD_UTILIZADA_E: TFloatField;
    cdsRestituicaoIcmsStINCVEN: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeletarPeriodoClick(Sender: TObject);

  private
    FNotasUtilizadas: TObjectList<TItemNotaValidacao>;
    arrClasFiscal: TConsultasArray;
    FCompras: TUniQuery;
    FVendas: TUniQuery;
    strClafis: string;

    procedure pCarregaLayoutImpressao;

    procedure pCarregaNotasCompraUtilizadas(stlAutoIncremCompra: TStringList);
    procedure pCarregaDadosCompras;
    procedure pCarregaDadosVendas;

    function fCarregaDados: boolean;
    procedure pCapturaCreditosVendas(fltSaldoVendido: double);
    procedure pCarregaCreditosDataSet(fltQuantidadeUtilizadaNfVenda: double);

    procedure pRegistraDadosRelatorioImpresso;
    procedure pRegistraCredito;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRelFiscRestituicaoIcms: TfrmRelFiscRestituicaoIcms;

implementation

uses untFuncoesSimples,
     untIFuncoes,
     strUtils,
     untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelFiscRestituicaoIcms.btnDeletarPeriodoClick(Sender: TObject);
  function fValidaPeriodoDigitado(strMesAno: string): boolean;
  begin
    Result := False;
    try
      StrToDate('01/' + strMesAno);
    except
      Result := True;
    end;
  end;

  var
    itemNotaUtilizada: TItemNotaValidacao;
    stlAutoIncremCompra: TStringList;
    intContador: Integer;
    strMesAno: string;
    qryAux: TUniQuery;
begin
  if InputQuery('Aviso', 'Informe um período para exclusão, ex: "MM/YYYY"', strMesAno) then
  begin
    if fValidaPeriodoDigitado(strMesAno) then
    begin
      fMensagem('', 'Período inválido, favor digitar nas normas "MM/YYYY"!', ['&Ok']);
      Exit;
    end;

    btnDeletarPeriodo.Enabled := False;
    btnImprimir.Enabled := False;
    pnlInfo.Caption := 'Deletando dados do período...';
    pnlInfo.Repaint;

    stlAutoIncremCompra := TStringList.Create;
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT * FROM COMUTI_DADOS WHERE UTI_MESANO = :MESANO ';
        ParamByName('MESANO').AsString := strMesAno;
        Open;

        //captura as gravações do periodo para voltar o saldo das quantidades ja utilizadas
        First;
        while not Eof do
        begin
          stlAutoIncremCompra.Add(FieldByName('UTI_INCCOM').AsString);

          Next;
        end;

        //carrega a lista de notas utilizadas a partir da data que o usuário deseja excluir
        pCarregaNotasCompraUtilizadas(stlAutoIncremCompra);

        First;
        while not Eof do
        begin
          for intContador := 0 to FNotasUtilizadas.Count - 1 do
          begin
            itemNotaUtilizada := TItemNotaValidacao(FNotasUtilizadas[intContador]);

            if (itemNotaUtilizada.strSeqGer = FieldByName('UTI_INCCOM').AsString) Then
            begin
              itemNotaUtilizada.fltQuantidadeUtilizada := itemNotaUtilizada.fltQuantidadeUtilizada -
                                                          FieldByName('UTI_QTDUTI').AsFloat;
            end;
          end;

          Next;
        end;

        Close;
        SQL.Clear;
        SQL.Add('REPLACE INTO COMUTI( ');
        SQL.Add(' AUTOINCREM, UTI_SEQGER, UTI_QTDUTI, UTI_TOTAL_) ');
        SQL.Add(' VALUES ( ');
        SQL.Add(' :AUTOINCREM, :SEQGER, :QTDUTI, :TOTAL_) ');

        for intContador := 0 to FNotasUtilizadas.Count - 1 do
        begin
          itemNotaUtilizada := TItemNotaValidacao(FNotasUtilizadas[intContador]);

          Close;
          ParamByName('AUTOINCREM').AsString := itemNotaUtilizada.strAutoIncrem;
          ParamByName('SEQGER').AsString := itemNotaUtilizada.strSeqGer;
          ParamByName('QTDUTI').AsFloat := itemNotaUtilizada.fltQuantidadeUtilizada;
          ParamByName('TOTAL_').AsFloat := itemNotaUtilizada.fltQuantidadeTotal;
          ExecSQL;
        end;

        //deletando dados do mês de referência
        Close;
        SQL.Clear;
        SQL.Text := 'DELETE FROM COMUTI_DADOS WHERE UTI_MESANO = :MESANO ';
        ParamByName('MESANO').AsString := strMesAno;
        ExecSQL;
      end;

      fMensagem('AVISO', 'Registros do período deletados com sucesso!', ['OK']);

      btnDeletarPeriodo.Enabled := True;
      btnImprimir.Enabled := True;
      pgbProgresso.Position := 0;
      pnlInfo.Caption := '';
      pnlInfo.Repaint;
    finally
      stlAutoIncremCompra.Free;
      qryAux.Free;
    end;


  end;
end;

procedure TfrmRelFiscRestituicaoIcms.btnImprimirClick(Sender: TObject);
  var
    objReImpressao: TReImpressaoRelatorio;
begin
  inherited;

  btnImprimir.Enabled := False;
  pnlInfo.Caption := 'Carregando Relatório...';
  pnlInfo.Repaint;

  objReImpressao := TReImpressaoRelatorio.Create;
  try
    if blnImprime then
    begin
      if objReImpressao.fReImpressao(cdsRestituicaoIcmsSt, StrToDate(mskDtaIni.Text), edtCodEmp.Text) then
        pCarregaLayoutImpressao
      else if fCarregaDados then
      begin
        pCarregaLayoutImpressao;

        //Verifica se vai ser gravado no banco as notas fiscais de entradas já utilizadas para crédito
        if fMensagem('ATENÇÃO', 'Confirma a utilização dos créditos do relatório apresentado?',
           ['&Sim', '&Não'], 2) = 1 then
        begin
          pnlInfo.Caption := 'Aguarde, gravando utilização de créditos...';
          Application.ProcessMessages;

          //registra as tabelas COMUTI
          pRegistraCredito;

          //registra os dados na tabela COMUTI_DADOS para reimpressão do que foi confirmado
          pRegistraDadosRelatorioImpresso;

          fMensagem('Aviso', 'Dados gravados com sucesso!', ['OK']);
        end;
      end
      else
        pTabelaVazia;

      btnImprimir.Enabled := True;
      pgbProgresso.Position := 0;
      pnlInfo.Caption := '';
      pnlInfo.Repaint;
    end;
  finally
    objReImpressao.Free;
  end;
end;

function TfrmRelFiscRestituicaoIcms.fCarregaDados: boolean;
begin
  //CARREGA AS COMPRAS JÁ UTILIZADAS PARA CRÉDITO
  pCarregaNotasCompraUtilizadas(nil);

  cdsRestituicaoIcmsSt.EmptyDataSet;

  //carrega o SQL das compras
  pCarregaDadosCompras;

  //Carrega as vendas para fora do estado
  pCarregaDadosVendas;

  with FVendas do
  begin
    First;
    while not Eof do
    begin
      FCompras.Close;
      FCompras.ParamByName('DATA_VENDA').AsDateTime := FieldByName('DTAENT').AsDateTime;
      FCompras.ParamByName('CODITE').AsString := FieldByName('ITEM').AsString;
      FCompras.ParamByName('CLACOM').AsString := VS_strClaCom;
      FCompras.ParamByName('ESPECIE').AsString := 'NF';
      FCompras.ParamByName('TIP_FC').AsString := 'F';

      if not fEmptyStr(edtCodEmp.Text) then
      begin
        FVendas.ParamByName('CODEMP').AsString := edtCodEmp.Text;
        FCompras.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      end;

      FCompras.Open;
      FCompras.First;

      pCapturaCreditosVendas(FieldByName('QTD_V').AsFloat);

      Next;
    end;
  end;

  Result := cdsRestituicaoIcmsSt.RecordCount > 0;
end;

procedure TfrmRelFiscRestituicaoIcms.FormCreate(Sender: TObject);
begin
  inherited;
  FNotasUtilizadas := TObjectList<TItemNotaValidacao>.Create;

  FCompras := fCriaQuery(nil);
  FVendas := fCriaQuery(nil);

  cdsRestituicaoIcmsSt.CreateDataSet;
end;

procedure TfrmRelFiscRestituicaoIcms.FormDestroy(Sender: TObject);
begin
  FNotasUtilizadas.Free;
  FCompras.Free;
  FVendas.Free;

  inherited;
end;

procedure TfrmRelFiscRestituicaoIcms.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

function TfrmRelFiscRestituicaoIcms.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskDtaIni) or (Sender = mskDtaFin) then
  begin
    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;

      if (Sender = mskDtaFin) then
        Sender := mskDtaIni;
    end
    else
    begin
      mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

      if (Sender = mskDtaFin) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
        begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        end
        else
        begin
          if StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) then
          begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          end
          else
            mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
        end;
      end
    end;
  end;

  if (Sender = edtCodEmp) then
  begin
    if not fEmptyStr(edtCodEmp.Text) and (edtCodEmp.Text <> '000') then
    begin
      if Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        edtNomEmp.Text := '';
        Result := False;
      end
      else
      begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
      end;
    end
    else
    begin
      edtNomEmp.Text := '';
    end;
  end

  else if (Sender = edtCodClaFis) then
  begin
    if (not fEmptyStr(edtCodClaFis.Text)) and
       (Pos(edtCodClaFis.Text, VS_strClaVen) <= 0) then
    begin
      fMensagem('ATENÇÃO!', 'Classificação selecionada não é uma CFOP de venda!', ['&Ok']);
      Result := False;
      edtCodClaFis.Clear;
      edtDesClaFis.Clear;
      pSetFocus(edtCodClaFis);
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmRelFiscRestituicaoIcms.pCapturaCreditosVendas(fltSaldoVendido: double);
  var
    fltSaldoComprado, fltQuantidadeUtilizada: double;
    itemNotaUtilizada: TItemNotaValidacao;
    blnAdicionar: Boolean;
    intContador: Integer;
begin
  with FCompras do
  begin
    First;

    while (fltSaldoVendido <> 0) and (not Eof) do
    begin
      fltSaldoComprado := FieldByName('QTDE').AsFloat;
      itemNotaUtilizada := nil;
      blnAdicionar := True;

      for intContador := 0 to FNotasUtilizadas.Count - 1 do
      begin
        itemNotaUtilizada := TItemNotaValidacao(FNotasUtilizadas[intContador]);

        // Se existir dentro da lista a nota que será processada, verificar se a mesma já foi utilizada totalmente
        if (itemNotaUtilizada.strSeqGer = FieldByName('AUTOINCREM').AsString) then
        begin
          if itemNotaUtilizada.fltQuantidadeUtilizada = itemNotaUtilizada.fltQuantidadeTotal then
            Next
          else
          begin
            fltSaldoComprado := Abs(itemNotaUtilizada.fltQuantidadeUtilizada - itemNotaUtilizada.fltQuantidadeTotal);
            blnAdicionar := False;
            Break;
          end;
        end;
      end;

      if fltSaldoVendido < fltSaldoComprado then
      begin
        fltQuantidadeUtilizada := fltSaldoVendido;
        fltSaldoVendido := 0;
      end
      else
      begin
        fltSaldoVendido := fltSaldoVendido - fltSaldoComprado;
        fltQuantidadeUtilizada := fltSaldoComprado;
      end;

      //Carrega o dataSet para amostragem do relatório
      pCarregaCreditosDataSet(fltQuantidadeUtilizada);

      //ALIMENTANDO A LISTA DE NOTAS DE ENTRADA UTILIZADAS
      if blnAdicionar then
      begin
        itemNotaUtilizada := TItemNotaValidacao.Create;
        itemNotaUtilizada.strAutoIncrem := fRetAutoIncrem('COMUTI', VS_strCodEmp);
        itemNotaUtilizada.strSeqGer := FieldByName('AUTOINCREM').AsString;
        itemNotaUtilizada.fltQuantidadeUtilizada := fltQuantidadeUtilizada;
        itemNotaUtilizada.fltQuantidadeTotal := FieldByName('QTDE').AsFloat;
        FNotasUtilizadas.Add(itemNotaUtilizada);
      end
      else
        itemNotaUtilizada.fltQuantidadeUtilizada := itemNotaUtilizada.fltQuantidadeUtilizada + fltQuantidadeUtilizada;

      Next;
    end;
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pCarregaCreditosDataSet(fltQuantidadeUtilizadaNfVenda: double);
begin
  with FCompras do
  begin
    cdsRestituicaoIcmsSt.Append;
    cdsRestituicaoIcmsSt.FieldByName('PRODUTO').AsString := FieldByName('PRODUTO').AsString;
    cdsRestituicaoIcmsSt.FieldByName('FORNECEDOR').AsString := FieldByName('FORNECEDOR').AsString;
    cdsRestituicaoIcmsSt.FieldByName('DOCUMENTO_E').AsString := FieldByName('DOCUMENTO').AsString;
    cdsRestituicaoIcmsSt.FieldByName('UF_FORNECEDOR').AsString := FieldByName('UF').AsString;
    cdsRestituicaoIcmsSt.FieldByName('VLR_E').AsFloat := FieldByName('VALOR_COMPRA').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('BC_ST_UNIT_E').AsFloat := FieldByName('BASE_ST_UNIT').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('QTD_E').AsFloat := FieldByName('QTDE').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('QTD_UTILIZADA_E').AsFloat := fltQuantidadeUtilizadaNfVenda;
    cdsRestituicaoIcmsSt.FieldByName('BC_ST_TOTAL_E').AsFloat := FieldByName('BASE_ST_TOTAL').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('ALIQ_INTERNA_E').AsFloat := 18;
    cdsRestituicaoIcmsSt.FieldByName('CRED_ST_E').AsFloat := FieldByName('CRED_ST_E').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('CRED_ICM_E').AsFloat := FieldByName('CRED_ICM_E').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('QTD_V').AsFloat := FVendas.FieldByName('QTD_V').AsFloat;
    cdsRestituicaoIcmsSt.FieldByName('DOCUMENTO_V').AsString := FVendas.FieldByName('DOCUMENTO').AsString;
    cdsRestituicaoIcmsSt.FieldByName('INCCOM').AsString := FieldByName('AUTOINCREM').AsString; //AUTOINCREM DA COMPRA
    cdsRestituicaoIcmsSt.FieldByName('INCVEN').AsString := FVendas.FieldByName('AUTINC_V').AsString; //AUTOINCREM DA VENDA
    cdsRestituicaoIcmsSt.Post;
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pCarregaDadosCompras;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  CONCAT(ITE_CODITE, " - ", ITE_DESITE) AS PRODUTO, ';
  strSQL := strSQL + '  CONCAT(FOR_CODFOR, " - ", FOR_NOMFOR) AS FORNECEDOR, ';
  strSQL := strSQL + '  D.DET_NUMDOC AS DOCUMENTO, ';
  strSQL := strSQL + '  CID_ESTADO AS UF, ';
  strSQL := strSQL + '  ((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) AS VALOR_COMPRA, ';
  strSQL := strSQL + '  ROUND((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0)) / D.DET_QTDITE, 2) AS BASE_ST_UNIT, ';
  strSQL := strSQL + '  D.DET_QTDITE AS QTDE, ';
  strSQL := strSQL + '  ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0), 2) AS BASE_ST_TOTAL, ';
  strSQL := strSQL + '  ROUND((IFNULL(D.DET_VALRET, 0) + IFNULL(T.DET_VAERET, 0)) / D.DET_QTDITE, 2) AS CRED_ST_E, ';
  strSQL := strSQL + '  ROUND((((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) * 12) / 100, 2) AS CRED_ICM_E ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CADITE ';
  strSQL := strSQL + '   ON ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = D.DET_CODFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN COMUTI ';
  strSQL := strSQL + '   ON UTI_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + 'WHERE (IFNULL(D.DET_VALRET, 0) + IFNULL(T.DET_VAERET, 0)) > 0';
  strSQL := strSQL + '  AND D.DET_DTAENT <= :DATA_VENDA ';
  strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';
  strSQL := strSQL + '  AND D.DET_ESPDOC = "NF" ';

  if not fEmptyStr(edtCodEmp.Text) then
    strSQL := strSQL + ' AND D.DET_CODEMP = :CODEMP ';

  strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ';
  strSQL := strSQL + '  AND D.DET_ESPDOC = :ESPECIE ';
  strSQL := strSQL + '  AND D.DET_TIP_FC = :TIP_FC ';
  strSQL := strSQL + '  AND IF(D.AUTOINCREM = UTI_SEQGER AND UTI_QTDUTI = UTI_TOTAL_, FALSE, TRUE) ';
  strSQL := strSQL + 'ORDER BY D.DET_DTAENT DESC ';

  with FCompras do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pCarregaDadosVendas;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.DET_NUMDOC AS DOCUMENTO, ';
  strSQL := strSQL + '  D.DET_QTDITE AS QTD_V, ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTINC_V, ';
  strSQL := strSQL + '  D.DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  D.DET_CODITE AS ITEM ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';

  strSQL := strSQL + 'WHERE D.DET_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND D.DET_CLAFIS >= 6000 ';
  strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0 ';
  strSQL := strSQL + '  AND LOCATE(D.DET_ESPDOC, :ESPECIE) > 0 ';

  if not fEmptyStr(edtDocumento.Text) then
    strSQL := strSQL + ' AND D.DET_NUMDOC = :NUMDOC ';

  if not fEmptyStr(edtCodEmp.Text) then
    strSQL := strSQL + ' AND D.DET_CODEMP = :CODEMP ';

  if not fEmptyStr(edtCodClaFis.Text) then
    strSQL := strSQL + fStrLocate(edtCodClaFis, arrClasFiscal, 'D.DET_CLAFIS', 'CLAFIS');

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');

  strSQL := 'SELECT TAB.* FROM (' + strSQL + ') AS TAB ORDER BY DOCUMENTO ';

  with FVendas do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    ParamByName('CLAVEN').AsString := VS_strClaVen;
    ParamByName('ESPECIE').AsString := 'NF_IF_';

    if not fEmptyStr(edtCodEmp.Text) then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    if not fEmptyStr(edtDocumento.Text) then
      ParamByName('NUMDOC').AsString := Trim(edtDocumento.Text);

    if not fEmptyStr(edtCodClaFis.Text) then
      pSetaParam(edtCodClaFis.Text, arrClasFiscal, strClafis, 'CLAFIS', FVendas);

    Open;
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pCarregaLayoutImpressao;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  frxRelatorioJ.Script.Variables['NOMEMP'] := fCadEmp('NOMEMP');
  frxRelatorioJ.Script.Variables['NOMREL'] := 'Restituição de ICMS e ICMS ST decorrente de vendas para outros estados';
  frxRelatorioJ.Script.Variables['REFERE'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

  if fEmptyStr(edtCodEmp.Text) then
  BEGIN
    frxRelatorioJ.Script.Variables['CODEMP'] := '';
  END
  ELSE
  BEGIN
    frxRelatorioJ.Script.Variables['CODEMP'] := edtCodEmp.Text + ' - ' + fRetNomeEmpresa(edtCodEmp.Text);
  END;

  frxRelatorioJ.Script.Variables['DOCUMENTO'] := fStrTitulo(edtDocumento.Text, nil, nil, '', 'DOCUMENTO', FALSE);
  frxRelatorioJ.Script.Variables['CLAFIS'] := fStrTitulo(edtCodClaFis.Text, edtDesClaFis, arrClasFiscal, strClafis, 'CFOP', TRUE);

  if frxRelatorioJ.PrepareReport then
  begin
    frxRelatorioJ.PrintOptions.PrintMode:= pmScale;
    frxRelatorioJ.PrintOptions.PrintOnSheet := 9;

    if edtDestino.Text = 'V' then
      pPreviewReport(Self.Name, Self.Caption, frxRelatorioJ)
    else
      pPrintReport(Self.Name, Self.Caption, strNomImp, frxRelatorioJ);
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pCarregaNotasCompraUtilizadas(stlAutoIncremCompra: TStringList);
  var
    itemNotaUtilizada: TItemNotaValidacao;
    qryAux: TUniQuery;
begin
  FNotasUtilizadas.Clear;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;

      if Assigned(stlAutoIncremCompra) then
      begin
        SQL.Text := ' SELECT * FROM COMUTI WHERE LOCATE(UTI_SEQGER, :INCREM) > 0 ';
        ParamByName('INCREM').AsString := stlAutoIncremCompra.CommaText;
      end
      else
        SQL.Text := ' SELECT * FROM COMUTI WHERE UTI_QTDUTI <> UTI_TOTAL_ ';

      Open;

      First;
      while not Eof do
      begin
        itemNotaUtilizada := TItemNotaValidacao.Create;
        itemNotaUtilizada.strAutoIncrem := FieldByName('AUTOINCREM').AsString;
        itemNotaUtilizada.strSeqGer := FieldByName('UTI_SEQGER').AsString;
        itemNotaUtilizada.fltQuantidadeUtilizada := FieldByName('UTI_QTDUTI').AsFloat;
        itemNotaUtilizada.fltQuantidadeTotal := FieldByName('UTI_TOTAL_').AsFloat;
        FNotasUtilizadas.Add(itemNotaUtilizada);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pRegistraCredito;
  var
    itemNotaUtilizada: TItemNotaValidacao;
    qryReplace: TUniQuery;
    intContador: Integer;
begin
  pgbProgresso.Visible := True;

  if FNotasUtilizadas.Count > 0 then
    pgbProgresso.Max := FNotasUtilizadas.Count - 1;

  pgbProgresso.Position := 0;

  qryReplace := fCriaQuery(nil);
  try
    with qryReplace do
    begin
      Close;
      SQL.Clear;
      SQL.Add('REPLACE INTO COMUTI( ');
      SQL.Add(' AUTOINCREM, UTI_SEQGER, UTI_QTDUTI, UTI_TOTAL_) ');
      SQL.Add(' VALUES ( ');
      SQL.Add(' :AUTOINCREM, :UTI_SEQGER, :UTI_QTDUTI, :UTI_TOTAL_) ');

      for intContador := 0 to FNotasUtilizadas.Count - 1 do
      begin
        itemNotaUtilizada := TItemNotaValidacao(FNotasUtilizadas[intContador]);

        Close;
        ParamByName('AUTOINCREM').AsString := itemNotaUtilizada.strAutoIncrem;
        ParamByName('UTI_SEQGER').AsString := itemNotaUtilizada.strSeqGer;
        ParamByName('UTI_QTDUTI').AsFloat := itemNotaUtilizada.fltQuantidadeUtilizada;
        ParamByName('UTI_TOTAL_').AsFloat := itemNotaUtilizada.fltQuantidadeTotal;
        ExecSQL;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
      end;
    end;
  finally
    qryReplace.Free;
  end;
end;

procedure TfrmRelFiscRestituicaoIcms.pRegistraDadosRelatorioImpresso;
  function fRetSQLInsert: string;
  begin
    Result := '';

    Result := Result + 'INSERT INTO COMUTI_DADOS ( ';
    Result := Result + '  AUTOINCREM, ';
    Result := Result + '  UTI_CODITE, ';
    Result := Result + '  UTI_CODFOR, ';
    Result := Result + '  UTI_NUMDOE, ';
    Result := Result + '  UTI_VLRCON, ';
    Result := Result + '  UTI_BCUNST, ';
    Result := Result + '  UTI_QTDITE, ';
    Result := Result + '  UTI_QTDUTI, ';
    Result := Result + '  UTI_BCTOST, ';
    Result := Result + '  UTI_ALQINT, ';
    Result := Result + '  UTI_CREDST, ';
    Result := Result + '  UTI_CREICM, ';
    Result := Result + '  UTI_QTDVEN, ';
    Result := Result + '  UTI_NUMDOV, ';
    Result := Result + '  UTI_INCCOM, ';
    Result := Result + '  UTI_INCVEN, ';
    Result := Result + '  UTI_MESANO ) ';
    Result := Result + 'VALUES ( ';
    Result := Result + '  :AUTOINCREM, ';
    Result := Result + '  :CODITE, ';
    Result := Result + '  :CODFOR, ';
    Result := Result + '  :NUMDOE, ';
    Result := Result + '  :VLRCON, ';
    Result := Result + '  :BCUNST, ';
    Result := Result + '  :QTDITE, ';
    Result := Result + '  :QTDUTI, ';
    Result := Result + '  :BCTOST, ';
    Result := Result + '  :ALQINT, ';
    Result := Result + '  :CREDST, ';
    Result := Result + '  :CREICM, ';
    Result := Result + '  :QTDVEN, ';
    Result := Result + '  :NUMDOV, ';
    Result := Result + '  :INCCOM, ';
    Result := Result + '  :INCVEN, ';
    Result := Result + '  :MESANO ) ';
  end;

  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLInsert;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := cdsRestituicaoIcmsSt.RecordCount;

      cdsRestituicaoIcmsSt.First;
      while not cdsRestituicaoIcmsSt.Eof do
      begin
        Close;
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('COMUTI_DADOS', VS_strCodEmp);
        ParamByName('CODITE').AsString := cdsRestituicaoIcmsSt.FieldByName('PRODUTO').AsString;
        ParamByName('CODFOR').AsString := cdsRestituicaoIcmsSt.FieldByName('FORNECEDOR').AsString;
        ParamByName('NUMDOE').AsString := cdsRestituicaoIcmsSt.FieldByName('DOCUMENTO_E').AsString;
        ParamByName('VLRCON').AsFloat := cdsRestituicaoIcmsSt.FieldByName('VLR_E').AsFloat;
        ParamByName('BCUNST').AsFloat := cdsRestituicaoIcmsSt.FieldByName('BC_ST_UNIT_E').AsFloat;
        ParamByName('QTDITE').AsFloat := cdsRestituicaoIcmsSt.FieldByName('QTD_E').AsFloat;
        ParamByName('QTDUTI').AsFloat := cdsRestituicaoIcmsSt.FieldByName('QTD_UTILIZADA_E').AsFloat; //QUANTIDADE UTILIZADA A PARTIR DA QUANTIDADE VENDIDA
        ParamByName('BCTOST').AsFloat := cdsRestituicaoIcmsSt.FieldByName('BC_ST_TOTAL_E').AsFloat;
        ParamByName('ALQINT').AsFloat := cdsRestituicaoIcmsSt.FieldByName('ALIQ_INTERNA_E').AsFloat;
        ParamByName('CREDST').AsFloat := cdsRestituicaoIcmsSt.FieldByName('CRED_ST_E').AsFloat;
        ParamByName('CREICM').AsFloat := cdsRestituicaoIcmsSt.FieldByName('CRED_ICM_E').AsFloat;
        ParamByName('QTDVEN').AsFloat := cdsRestituicaoIcmsSt.FieldByName('QTD_V').AsFloat;
        ParamByName('NUMDOV').AsString := cdsRestituicaoIcmsSt.FieldByName('DOCUMENTO_V').AsString;
        ParamByName('INCCOM').AsString := cdsRestituicaoIcmsSt.FieldByName('INCCOM').AsString;
        ParamByName('INCVEN').AsString := cdsRestituicaoIcmsSt.FieldByName('INCVEN').AsString;
        ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));
        ExecSQL;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;

        cdsRestituicaoIcmsSt.Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

{ TReImpressaoRelatorio }

function TReImpressaoRelatorio.fReImpressao(cdsAux: TUniClientDataSet; dtaExportacao: TDateTime; strCodEmp: String): boolean;
begin
  FCdsDados := cdsAux;
  FDataExportacao := dtaExportacao;
  FCodEmp := strCodEmp;

  pCarregaDados;

  Result := FCdsDados.RecordCount > 0;
end;

procedure TReImpressaoRelatorio.pCarregaDados;
  function fRetSQL: string;
  begin
    Result := '';

    Result := Result + 'SELECT ';
    Result := Result + '  CONCAT(UTI_CODITE, " - ", ITE_DESITE)  AS UTI_CODITE, ';
    Result := Result + '  CONCAT(UTI_CODFOR, " - ", FOR_NOMFOR)  AS UTI_CODFOR, ';
    Result := Result + '  CID_ESTADO AS FOR_ESTADO, ';
    Result := Result + '  UTI_NUMDOE, ';
    Result := Result + '  UTI_VLRCON, ';
    Result := Result + '  UTI_BCUNST, ';
    Result := Result + '  UTI_QTDITE, ';
    Result := Result + '  UTI_BCTOST, ';
    Result := Result + '  UTI_ALQINT, ';
    Result := Result + '  UTI_CREDST, ';
    Result := Result + '  UTI_CREICM, ';
    Result := Result + '  UTI_QTDVEN, ';
    Result := Result + '  UTI_NUMDOV ';
    Result := Result + 'FROM ';
    Result := Result + '  COMUTI_DADOS ';

    Result := Result + '  LEFT JOIN CADFOR ';
    Result := Result + '    ON FOR_CODFOR = UTI_CODFOR ';

    Result := Result + '  LEFT JOIN CADITE ';
    Result := Result + '    ON ITE_CODITE = UTI_CODITE ';

    Result := Result + '  LEFT JOIN CADCID ';
    Result := Result + '    ON CID_CODCID = FOR_CODCID ';

    if not fEmptyStr(FCodEmp) then
    begin

      Result := Result + '  LEFT JOIN MOVDET AS DE ';
      Result := Result + '    ON DE.DET_NUMDOC = UTI_NUMDOE AND DE.DET_CODITE = UTI_CODITE ';

      Result := Result + '  LEFT JOIN MOVDET AS DV ';
      Result := Result + '    ON DV.DET_NUMDOC = UTI_NUMDOV AND DV.DET_CODITE = UTI_CODITE ';

    end;

    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND UTI_MESANO = :MESANO ';

    if not fEmptyStr(FCodEmp) then
    begin
      Result := Result + 'AND DE.DET_CODEMP = :CODEMP ';
      Result := Result + 'AND DV.DET_CODEMP = :CODEMP ';
    end;

  end;

  var
    qryAux: TUniQuery;
begin
  pInicializaDados;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQL;

      ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FDataExportacao);

      if not fEmptyStr(FCodEmp) then
      begin
        ParamByName('CODEMP').AsString := FCodEmp;
      end;

      Open;

      First;
      while not Eof do
      begin
        FCdsDados.Append;
        FCdsDados.FieldByName('PRODUTO').AsString := FieldByName('UTI_CODITE').AsString;
        FCdsDados.FieldByName('FORNECEDOR').AsString := FieldByName('UTI_CODFOR').AsString;
        FCdsDados.FieldByName('UF_FORNECEDOR').AsString := FieldByName('FOR_ESTADO').AsString;
        FCdsDados.FieldByName('DOCUMENTO_E').AsString := FieldByName('UTI_NUMDOE').AsString;
        FCdsDados.FieldByName('VLR_E').AsFloat := FieldByName('UTI_VLRCON').AsFloat;
        FCdsDados.FieldByName('BC_ST_UNIT_E').AsFloat := FieldByName('UTI_BCUNST').AsFloat;
        FCdsDados.FieldByName('QTD_E').AsFloat := FieldByName('UTI_QTDITE').AsFloat;
        FCdsDados.FieldByName('BC_ST_TOTAL_E').AsFloat := FieldByName('UTI_BCTOST').AsFloat;
        FCdsDados.FieldByName('ALIQ_INTERNA_E').AsFloat := FieldByName('UTI_ALQINT').AsFloat;
        FCdsDados.FieldByName('CRED_ST_E').AsFloat := FieldByName('UTI_CREDST').AsFloat;
        FCdsDados.FieldByName('CRED_ICM_E').AsFloat := FieldByName('UTI_CREICM').AsFloat;
        FCdsDados.FieldByName('QTD_V').AsFloat := FieldByName('UTI_QTDVEN').AsFloat;
        FCdsDados.FieldByName('DOCUMENTO_V').AsString := FieldByName('UTI_NUMDOV').AsString;
        FCdsDados.Post;

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TReImpressaoRelatorio.pInicializaDados;
begin
  FCdsDados.EmptyDataSet;
  FCdsDados.Filter := '';
  FCdsDados.Filtered := False;
end;

end.
