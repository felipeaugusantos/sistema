unit untAbstractCalculadorNotaFiscalEspecialTintometrico;

interface

uses
  untFuncFat, untFuncFatTypes, ComCtrls, Uni, untITelaGravandoExecucao, SysUtils,
  untITelaGravando;

type
  TAbstractCalculadorNotaFiscalEspecialTintometrico = class abstract(TInterfacedObject, ITelaGravandoExecucao)
  private
    qryTinMovDet: TUniQuery;
    qryTinDet: TUniQuery;
    qryTmp: TUniQuery;

    procedure pAbreTmp;
    procedure pFechaTmp;
    function fOpcaoTintometrico: String;
  protected
    fatVendas: TFatVenda;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    pAddItem: TPAdicionaItem;
    pgbProgresso: TProgressBar;
    pCancNFEspecial: TPCancNFEspecial;
    blnCancelar: Boolean;
  private
    procedure AcertaValores(const tela: ITelaGravando; const fltTotalTinDet: Double);
    function GetCodigoMovDetSQL(const strTinDet, strMovDet: string): string;

  protected
    function GetTinDet(): TUniQuery;
    function GetSQLTinDet(): string; virtual; abstract;

    procedure ProcessarTinDet(const tela: ITelaGravando; const qryTinDet: TUniQuery; out fltTotSub: Double); virtual; abstract;
    procedure pCriaTabelaNfEspiritoSanto; virtual; abstract;
    procedure ProcessarTempNfEspiritoSanto(const tela: ITelaGravando; qryTmp: TUniQuery); virtual; abstract;

  public
    constructor Create(const fatVendas: TFatVenda; const dtaDtaIni, dtaDtaFin: TDateTime;
      const pAddItem: TPAdicionaItem; const pgbProgresso: TProgressBar; const pCancNFEspecial: TPCancNFEspecial); reintroduce; virtual;

    procedure Executar(const tela: ITelaGravando);

    function SetQryTinMovDet(const qryTinMovDet: TUniQuery): TAbstractCalculadorNotaFiscalEspecialTintometrico;

    function fExisteNFTintometricoPendente: Boolean; virtual; abstract;
  end;

implementation

uses
   untFuncoesSimples, Data.DB, Shared.Functions.Types;


{ TCalculadorNotaFiscalEspecialTintometrico }

procedure TAbstractCalculadorNotaFiscalEspecialTintometrico.AcertaValores(const tela: ITelaGravando;
  const fltTotalTinDet: Double);

  function fTotalInseridoNoGrid: Double;
  begin
    Result := 0;
    cdsVenda.First;
    while not cdsVenda.Eof do
    begin
      Result := Result + cdsVenda.FieldByName('ITE_TOTITE').AsFloat;
      cdsVenda.Next;
    end;
  end;

Var
  intTentativaArredondamento,
  intRecNo: Integer;
  fltFator: Double;
begin
  intRecNo := 0;

  If cdsVenda.IsEmpty Then
  Begin
    fMensagem('Atenção','Nenhum produto foi processado para a opção: ' + #13#10 + fOpcaoTintometrico,['&Ok']);
    Exit;
  End;

  Try
    Try
      intRecNo := cdsVenda.RecNo;
      cdsVenda.DisableConstraints;
      cdsVenda.DisableControls;

      fltFator := fltTotalTinDet / fTotalInseridoNoGrid;

      If (fFormataFloat(fltFator, 4) = 1) Then
        Exit;

      intTentativaArredondamento := 0;
      tela.Texto := 'Ajustando valores';
      While (fltFator <> 1) And (intTentativaArredondamento<=10) Do
      Begin
        cdsVenda.First;
        while not cdsVenda.Eof do
        begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_UNITAR').AsFloat := fFormataFloat(cdsVenda.FieldByName('ITE_UNITAR').AsFloat * fltFator, 4);
          cdsVenda.FieldByName('ITE_TOTITE').AsFloat := fFormataFloat(cdsVenda.FieldByName('ITE_UNITAR').AsFloat * cdsVenda.FieldByName('ITE_QTDITE').AsFloat, 2);
          cdsVenda.Post;
          cdsVenda.Next;
          tela.RegistrarProgresso(0, cdsVenda.RecNo, cdsVenda.RecordCount);
        end;

        fltFator := fltTotalTinDet / fTotalInseridoNoGrid;
        Inc(intTentativaArredondamento);
      End;
      cdsVenda.First;

      tela.Texto := 'Preenchendo Matriz de Fechamento';
      fatVendas.pPreencheMatrizFechamento();

      tela.Texto := 'Aguarde, Calculando total dos produtos';
      fatVendas.pCalculaTotGer();

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsVenda.RecNo := intRecNo;
    cdsVenda.EnableConstraints;
    cdsVenda.EnableControls;
  End;                            
end;

constructor TAbstractCalculadorNotaFiscalEspecialTintometrico.Create(const fatVendas: TFatVenda; const dtaDtaIni, dtaDtaFin: TDateTime;
  const pAddItem: TPAdicionaItem; const pgbProgresso: TProgressBar; const pCancNFEspecial: TPCancNFEspecial);
begin
  inherited Create();
  Self.fatVendas := fatVendas;
  Self.dtaDtaIni := dtaDtaIni;
  Self.dtaDtaFin := dtaDtaFin;
  Self.pAddItem := pAddItem;
  Self.pgbProgresso := pgbProgresso;
  Self.qryTinDet := nil;
  Self.pCancNFEspecial := pCancNFEspecial;
  Self.blnCancelar := False;
end;

procedure TAbstractCalculadorNotaFiscalEspecialTintometrico.Executar(const tela: ITelaGravando);
var
  fltTotSub,
  fltTotal: Double;
begin
  Try
    Try
      tela.Texto := 'Processando itens';
      fatVendas.blnNotEsp := True;
      GetTinDet.First;

      fDropTable('TMP_NFESPIRITOSANTO');
      pCriaTabelaNfEspiritoSanto;

      if GetTinDet.IsEmpty then
        Exit;

      fltTotal := 0;
      while not GetTinDet.Eof do
      begin
        Try
          Try
            ProcessarTinDet(tela, GetTinDet, fltTotSub);
            If fCfgSis('TINESP') = 'PREÇO DE VENDA' Then
              fltTotal := fltTotal + (GetTinDet.FieldByName('TOTITE').AsFloat - fltTotSub)
            Else
              fltTotal := fltTotal + (GetTinDet.FieldByName('TOTCUS').AsFloat - fltTotSub);

            If blnCancelar Then
              Exit;
          Except
            on E: Exception do
            begin
              raise;
            end;
          End;
        Finally
          GetTinDet.Next;
          tela.RegistrarProgresso(0, GetTinDet.RecNo, GetTinDet.RecordCount);
        End;
      end;

      Try
        pAbreTmp;

        qryTmp.First;
        While Not qryTmp.Eof Do
        Begin
          Try
            Try
              ProcessarTempNfEspiritoSanto(tela, qryTmp);
            Except
              on E: Exception do
              begin
                raise;
              end;
            End;
          Finally
            qryTmp.Next;
            tela.RegistrarProgresso(0, qryTmp.RecNo, qryTmp.RecordCount);
          End;
        End;
      Finally
        pFechaTmp;
      End;

      AcertaValores(tela, fltTotal);

      fDropTable('TMP_NFESPIRITOSANTO');

    Except
      on E: Exception do
      begin
        raise;
        fDropTable('TMP_NFESPIRITOSANTO');
      end;
    End;
  Finally
    fDropTable('TMP_NFESPIRITOSANTO');
  End;
end;

function TAbstractCalculadorNotaFiscalEspecialTintometrico.fOpcaoTintometrico: String;
begin
  Case fatVendas.opcItensNFespTinta Of
    opcProdutoAcabado                     : Result := 'Produto Acabado';
    opcBasesColorantesSemDestaqueImpostos : Result := 'Bases/Colorantes (Imobiliárias/Automotivas/Industriais), Sem destaque de impostos';
    opcBasesColorantesComDestaqueImpostos : Result := 'Bases/Colorantes (Imobiliárias/Automotivas/Industriais), Com destaque de impostos';
    opcColorantesTributados               : Result := 'Somente colorantes tributados de imobiliárias';
    opcColorantesNaoTributados            : Result := 'Somente colorantes não tributados de imobiliárias';
  End;
end;

function TAbstractCalculadorNotaFiscalEspecialTintometrico.GetCodigoMovDetSQL(
  const strTinDet, strMovDet: string): string;
begin
  Result :=
    ' SELECT                                                                  ' +
    '   SQL_NO_CACHE DET_PROEMB                                               ' +
    '   , D.AUTOINCREM AS CHAVE                                               ' +
    '   , D.DET_ITEEMB                                                        ' +
    '   , T.DET_IDEPRO                                                        ' +
    '   , T.DET_CODEMP                                                        ' +
    '   , T.DET_CODITE                                                        ' +
    '   , T.DET_DESCRI                                                        ' +
    '   , "MOVTIN" AS TABELA                                                  ' +
    ' FROM                                                                    ' +
    '   TINDET T                                                              ' +
    '   INNER JOIN MOVDET D                                                   ' +
    '      ON D.DET_NUMDOC = T.DET_NUMDOC                                     ' +
    '     AND D.DET_ESPDOC = T.DET_ESPDOC                                     ' +
    '     AND D.DET_CODEMP = T.DET_CODEMP                                     ' +
    '     AND D.DET_CODCLI = T.DET_CODCLI                                     ' +
    '     AND D.DET_CODITE = T.DET_CODITE                                     ' +
    '     AND D.DET_CODACA = T.DET_CODACA                                     ' +
    '     AND D.DET_EMPACA = T.DET_EMPACA                                     ' +
    '   INNER JOIN ITEGER G                                                   ' +
    '      ON G.ITE_CODITE = D.DET_CODITE                                     ' +
    '     AND G.ITE_CODEMP = D.DET_CODEMP                                     ' +
    ' WHERE T.DET_DTAENT BETWEEN :DTAINI                                      ' +
    '   AND :DTAFIN                                                           ' +
    '   AND T.DET_CODEMP = :CODEMP                                            ';

  if Assigned(fatVendas) then
  begin
    Result := Result                                                            +
      '   AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0                               ';
  end;

  Result := Result                                                              +
    '   AND D.DET_ESPDOC IN ("NF","EL","IF","IV","NV")                        ' +
    '   AND D.DET_PROEMB <> "S"                                               ' +
    '  ORDER BY                                                               ' +
    '    D.AUTOINCREM                                                         ';
end;

function TAbstractCalculadorNotaFiscalEspecialTintometrico.GetTinDet: TUniQuery;
begin
  if not Assigned(qryTinDet) then
  begin
    qryTinDet := fCriaQuery();
    qryTinDet.SQL.Text := GetSQLTinDet;
    qryTinDet.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryTinDet.ParamByName('DTAFIN').AsDate := dtaDtaFin;
    qryTinDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTinDet.ParamByName('CLAVEN').AsString := fatVendas.VS_strClaVen;
  end;

  qryTinDet.Open;
  Result := qryTinDet;
end;

procedure TAbstractCalculadorNotaFiscalEspecialTintometrico.pAbreTmp;
begin
  qryTmp := fCriaQuery;
  qryTmp.SQL.Clear;
  qryTmp.SQL.Add(' SELECT * FROM TMP_NFESPIRITOSANTO ');
  qryTmp.Open;
end;

procedure TAbstractCalculadorNotaFiscalEspecialTintometrico.pFechaTmp;
begin
  FreeAndNil(qryTmp);
end;

function TAbstractCalculadorNotaFiscalEspecialTintometrico.SetQryTinMovDet(
  const qryTinMovDet: TUniQuery): TAbstractCalculadorNotaFiscalEspecialTintometrico;
begin
  Result := Self;

  Self.qryTinMovDet := qryTinMovDet;

  if Assigned(qryTinMovDet) then
  begin
    qryTinMovDet.SQL.Text := GetCodigoMovDetSQL('TINDET', 'MOVDET');
    qryTinMovDet.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryTinMovDet.ParamByName('DTAFIN').AsDate := dtaDtaFin;
    qryTinMovDet.ParamByName('CODEMP').AsString := VS_strCodEmp;

    if Assigned(fatVendas) then
      qryTinMovDet.ParamByName('CLAVEN').AsString := fatVendas.VS_strClaVen;

    qryTinMovDet.Open;
  end;
end;

end.
