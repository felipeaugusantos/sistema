unit untFatExpedicaoBuscaEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, Uni, AppEvnts, BitBtnLockedIncrem, QColorLabel, frxClass,
  frxExportCSVTestabilidade, untZClient, UniClientDataSet, UniDataSetProvider,
  Data.DB, Datasnap.DBClient;

Type
  TfrmFatExpedicaoBuscaEstoque = class(TfrmPai)
    pnlGeral: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlFiltros: TPanel;
    rdgEstoque: TRadioGroup;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryItens : TUniQuery;
    dspItens : TUniDataSetProvider;
    blnUsaQtdPenEntFut: Boolean;
    blnBaiSubIte : Boolean;
  public
    { Public declarations }
    cdsItens : TUniClientDataSet;
    DataSetPedidos : TDataSet;
    blnExiPedRetiraExpAntFat: Boolean;
    stlSeqFgo : TStringList;
    procedure pProcessarSaldoEstoque;
  end;

var
  frmFatExpedicaoBuscaEstoque: TfrmFatExpedicaoBuscaEstoque;

implementation

uses untFuncoesSimples, untFatExpedicaoItens, untFuncFatTypes,
     System.Generics.Collections, untIFatEntregaFutura, untTFatEntregaFutura,
  untFuncFat;

{$R *.dfm}

procedure TfrmFatExpedicaoBuscaEstoque.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatExpedicaoBuscaEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  qryItens := fCriaQuery(Self);
  cdsItens := TUniClientDataSet.Create(Self);
  dspItens := TUniDataSetProvider.Create(Self);
  dspItens.DataSet := qryItens;

  blnUsaQtdPenEntFut := fUsaQtdPendenteEntregaFutura;
  blnBaiSubIte := (fCfgSis('BXSBIT') <> '1');
end;

procedure TfrmFatExpedicaoBuscaEstoque.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryItens);
  FreeAndNil(cdsItens);
  FreeAndNil(dspItens);
end;

procedure TfrmFatExpedicaoBuscaEstoque.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirma);
end;

procedure TfrmFatExpedicaoBuscaEstoque.pProcessarSaldoEstoque;
  Var
    strSQL : String;
    fltSalAtu : Double;
    stlPedidos : TStringList;
    intCnt : Integer;
    subItem: TSubItemEstrutura;
    objItensEstrutura : TItensEstrutura;
    blnTemSaldoTodosSubItens : Boolean;
    strFilter : String;
    blnFiltered : Boolean;
    cdsSaldos : TUniClientDataSet;
    dicSaldos : TDictionary<String, Double>;
    strChave : String;

  function fSaldo: Double;
    Var
      fltSomaQtdExp : Double;
  begin
    strChave := cdsItens.FieldByName('CODITE').AsString +
                cdsItens.FieldByName('CODEMP').AsString;

    If Not dicSaldos.ContainsKey(strChave) Then
    Begin
      cdsSaldos.Filtered := False;
      cdsSaldos.Filter := 'CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) + ' AND ' +
                          'CODEMP = ' + QuotedStr(cdsItens.FieldByName('CODEMP').AsString) ;
      cdsSaldos.Filtered := True;

      fltSomaQtdExp := 0;

      cdsSaldos.First;
      While Not cdsSaldos.Eof Do
      Begin
        fltSomaQtdExp := fltSomaQtdExp + cdsSaldos.FieldByName('QTDEXP').AsFloat;
        cdsSaldos.Next;
      End;

      dicSaldos.AddOrSetValue(strChave, cdsItens.FieldByName('SALDOS').AsFloat - fltSomaQtdExp);
    End;

    Result := dicSaldos[strChave];
  end;

begin
  strSQL := '';
  strSQL := strSQL + ' SELECT FDO_CODITE AS CODITE, ';
  strSQL := strSQL + '        FDO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + ' FATDOR.FDO_SEQGER AS SEQGER, ';
  strSQL := strSQL + ' (FDO_QTDITE - FDO_QTDBAI) AS QTDITE, ';
  strSQL := strSQL + ' IFNULL(EXTDOR.FDO_QTDEXP, 0.00) AS QTDEXP, ';
  strSQL := strSQL + ' (SELECT COUNT(*) ';
  strSQL := strSQL + '    FROM GERMAT ';
  strSQL := strSQL + '   WHERE GERMAT.GMT_CODITE = FATDOR.FDO_CODITE) AS ESTRUT, ';
  strSQL := strSQL + ' "N" AS TEMSAL  ';

  cdsSaldos := Nil;
  stlPedidos := TStringList.Create;
  Try
    stlPedidos.Clear;
    stlSeqFgo.Clear;

    strFilter := DataSetPedidos.Filter;
    blnFiltered := DataSetPedidos.Filtered;
    Try
      DataSetPedidos.Filtered := False;
      DataSetPedidos.First;
      While Not DataSetPedidos.Eof Do
      Begin
        stlPedidos.Add(DataSetPedidos.FieldByName('AUTINC').AsString);
        DataSetPedidos.Next;
      End;
    Finally
      DataSetPedidos.Filter := strFilter;
      DataSetPedidos.Filtered := blnFiltered;
    End;

    With qryItens Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      TfrmFatExpedicaoItens.pSqlFrom(qryItens.SQL, False, blnExiPedRetiraExpAntFat,
        False, False, '', Nil, False);

      SQL.Add(' AND FATDOR.FDO_SEQGER IN (' + fCommaText(stlPedidos, True) + ')'    );
      SQL.Add(' ORDER BY ');
      SQL.Add(' FATGOR.FGO_DTAENT, FATDOR.FDO_SEQGER ');

      TfrmFatExpedicaoItens.pSqlParams(qryItens);

      Open;
    End;

    pSetaClient(qryItens);

    cdsItens.Close;
    cdsItens.SetProvider(dspItens);
    cdsItens.Open;

    If (VS_strTipExp = '4') Then
    Begin
      cdsSaldos := TUniClientDataSet.Create(Self);
      dicSaldos := TDictionary<String, Double>.Create;
      pCloneDataSet(cdsSaldos, cdsItens);
    End;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin

      If (cdsItens.FieldByName('ESTRUT').AsInteger > 0) And
         (blnBaiSubIte) Then
      Begin
        If (fCfgSis('BXSBIT') = '3') Then
        Begin
          fltSalAtu := fSaldo;

          If (blnUsaQtdPenEntFut) Then
            fltSalAtu := fltSalAtu + TEntregaFutura.New(
                                       TParamEF.New()
                                         .CodIte(cdsItens.FieldByName('CODITE').AsString)
                                         .CodEmp(VS_strCodEmp)
                                         .Faturamento(True)
                                       ).Total();
        End
        Else
          fltSalAtu := 0;

        If (fltSalAtu > 0) Then
        Begin
          cdsItens.Edit;
          cdsItens.FieldByName('TEMSAL').AsString := 'S';
          cdsItens.Post;
        End
        // Não tem saldo no item estrutura, verifica dos sub-itens:
        Else If (fltSalAtu <= 0) Then
        Begin
          objItensEstrutura := TItensEstrutura.Create;
          Try
            objItensEstrutura.pCarregarEstrutura(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('QTDITE').AsFloat);
            If (objItensEstrutura.ItemsCount > 0) Then
            Begin
              blnTemSaldoTodosSubItens := True;

              For intCnt := 0 To objItensEstrutura.ItemsCount -1 Do
              Begin
                subItem := objItensEstrutura[intCnt];

                fltSalAtu := subItem.fltSaldos;

                If Not (fltSalAtu >= subItem.fltQtdTot) Then
                  blnTemSaldoTodosSubItens := False;
              End;

              cdsItens.Edit;
              cdsItens.FieldByName('TEMSAL').AsString := IIF(blnTemSaldoTodosSubItens, 'S', 'N');
              cdsItens.Post;
            End;
          Finally
            FreeAndNil(objItensEstrutura);
          End;
        End;
      End
      Else
      Begin
        fltSalAtu := fSaldo;

        If (blnUsaQtdPenEntFut) Then
          fltSalAtu := fltSalAtu + TEntregaFutura.New(
                                     TParamEF.New()
                                       .CodIte(cdsItens.FieldByName('CODITE').AsString)
                                       .CodEmp(VS_strCodEmp)
                                       .Faturamento(True)
                                     ).Total();

        If (fltSalAtu > 0) Then
        Begin
          cdsItens.Edit;
          cdsItens.FieldByName('TEMSAL').AsString := 'S';
          cdsItens.Post;
        End
        Else
        Begin
          cdsItens.Edit;
          cdsItens.FieldByName('TEMSAL').AsString := 'N';
          cdsItens.Post;
        End;
      End;

      If (cdsItens.FieldByName('QTDEXP').AsFloat > 0) And
         (cdsItens.FieldByName('TEMSAL').AsString = 'N') Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('TEMSAL').AsString := 'S';
        cdsItens.Post;
      End;

      If (cdsItens.FieldByName('TEMSAL').AsString = 'S') And
         (rdgEstoque.ItemIndex = 0) Then
      Begin
        If stlSeqFgo.IndexOf(cdsItens.FieldByName('SEQGER').AsString) < 0 Then
          stlSeqFgo.Add(cdsItens.FieldByName('SEQGER').AsString);
      End;

      If (cdsItens.FieldByName('TEMSAL').AsString = 'N') And
         (rdgEstoque.ItemIndex = 1) Then
      Begin
        If stlSeqFgo.IndexOf(cdsItens.FieldByName('SEQGER').AsString) < 0 Then
          stlSeqFgo.Add(cdsItens.FieldByName('SEQGER').AsString);
      End;

      cdsItens.Next;
    End;

    cdsItens.Filter := 'TEMSAL = ' + QuotedStr(IIF(rdgEstoque.ItemIndex = 0, 'N', 'S'));
    cdsItens.Filtered := True;

    While (Not cdsItens.Eof) Do
      cdsItens.Delete;

    cdsItens.Filtered := False;
  Finally
    FreeAndNil(stlPedidos);
    If Assigned(cdsSaldos) Then
      FreeAndNil(cdsSaldos);
    If Assigned(dicSaldos) Then
      FreeAndNil(dicSaldos);
  End;
end;

end.
