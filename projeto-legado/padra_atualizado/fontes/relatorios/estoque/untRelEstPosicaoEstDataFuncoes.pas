unit untRelEstPosicaoEstDataFuncoes;

interface

Uses Uni, untFuncoesFactory, EditFocus, untTypesSistema,
     StdCtrls, ExtCtrls, MaskEditFocus, StrUtils, SysUtils,
     ComboBoxFocus, untIFuncoes;

Type
  TParPosicaoEstDataThread = Record
    arrLinhaSim        : TConsultasArray;
    arrLinhaNao        : TConsultasArray;
    arrProduto         : TConsultasArray;
    arrAbrevFis        : TConsultasArray;
    arrFornecedor      : TConsultasArray;
    arrMarca           : TConsultasArray;
    arrCodDep          : TConsultasArray;
    arrUnidade         : TconsultasArray;
    arrEmpresa         : TconsultasArray;
    arrGruCmp          : TconsultasArray;
    mskLinGruSim       : TMaskEditFocus;
    mskLinGruNao       : TMaskEditFocus;
    edtDescri          : TEditFocus;
    edtLocFis          : TEditFocus;
    edtRefere          : TEditFocus;
    edtRefFin          : TEditFocus;
    edtTabPre          : TEditFocus;
    cbxTipPre          : TComboBox;
    edtOpcao           : TEditFocus;
    cbxQuebra          : TComboBoxFocus;
    rdgStatus          : TRadioGroup;
    rdgBroker          : TRadioGroup;
    edtSaldos          : TEditFocus;
    cbxOpcaoSint       : TComboBox;
    chkSalAba          : TCheckBox;
    edtSalAba          : TEditFocus;
    chkSalAci          : TCheckBox;
    edtSalAci          : TEditFocus;
    mskDtaSal          : TMaskEditFocus;
    rdgLotesDeProdutos : TRadioGroup;
    edtProdutos        : TEditFocus;
    edtAbrevFis        : TEditFocus;
    edtFornecedor      : TEditFocus;
    edtMarca           : TEditFocus;
    edtCodDep          : TEditFocus;
    edtCodEmpresa      : TEditFocus;
    edtUnidade         : TEditFocus;
    edtGruCmp          : TEditFocus;

    blnQtdCai  : Boolean;

    strLinGru  : String;
    strLinPro  : String;
    strLinAbre : String;
    strLinFor  : String;
    strLinMar  : String;
    strCodDep  : String;
    strLinEmp  : String;
    strGruSim  : String;
    strGruNao  : String;
    strLinUni  : String;
    strGruCmp  : String;

  End;


function fGetFiltros(recPar : TParPosicaoEstDataThread) : String;
procedure pSetParametros(recPar : TParPosicaoEstDataThread; qryDados : TUniQuery);
Function fSQLPrecoCusto(recPar : TParPosicaoEstDataThread; strAlias: String): String;

implementation

function fGetFiltros(recPar : TParPosicaoEstDataThread): String;
begin
  With recPar Do
  Begin
    Result := '';

    Case rdgStatus.ItemIndex Of
      0: Result := Result + '  AND I.ITE_ITEATI = "S" ';
      1: Result := Result + '  AND I.ITE_ITEATI = "N" ';
    End;

    {************************************}
    { ITENS COM LOTES: SIM, NÃO E TODOS  }
    {*********************************CI*}

    Case rdgLotesDeprodutos.ItemIndex Of
      0: Result := Result + '  AND IFNULL(LOT_NUMLOT, "") <> "" ';
      1: Result := Result + '  AND IFNULL(LOT_NUMLOT, "") = "" ';
    End;

    Case rdgBroker.ItemIndex Of
      0: Result := Result + '  AND ((LOT_NUMLOT IS NULL) OR (LOT_BROKER =  "S")) ';
      1: Result := Result + '  AND ((LOT_NUMLOT IS NULL) OR (LOT_BROKER <> "S")) ';
    End;

    If Not fEmptyStr(mskLinGruSim.Text) Then
    Begin
      Result := Result + fStrLocateLinGru(mskLinGruSim, arrLinhaSim, 'I.ITE_CODGRU', 'GRUSIM' );
      {
      If Length(arrLinhaSim) > 1 Then
        Result := Result + '  AND LOCATE(I.ITE_CODGRU,:GRUSIM) > 0 '
      Else
      Begin
        If RightStr(mskLinGruSim.Text,3) = '000' Then
          Result := Result + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:GRUSIM,3) '
        Else
          Result := Result + '  AND I.ITE_CODGRU = :GRUSIM ';
      End;
      }
    End;

    If Not fEmptyStr(mskLinGruNao.Text) Then
    Begin
      Result := Result + fStrLocateLinGru(mskLinGruNao, arrLinhaNao, 'I.ITE_CODGRU', 'GRUNAO', False, True);
      {
      If Length(arrLinhaNao) > 1 Then
        Result := Result + '  AND LOCATE(I.ITE_CODGRU,:GRUNAO) <= 0 '
      Else
      Begin
        If RightStr(mskLinGruNao.Text,3) = '000' Then
          Result := Result + '  AND LEFT(I.ITE_CODGRU,3) <> LEFT(:GRUNAO,3) '
        Else
          Result := Result + '  AND I.ITE_CODGRU <> :GRUNAO ';
      End;
      }
    End;

    Result := Result + fStrLocate(edtMarca, arrMarca, 'I.ITE_CODMAR','CODMAR');
    Result := Result + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');

    {**********************************}
    {* FILTRO DEPARTAMENTO DO PRODUTO *}
    {*******************************RM*}
    Result := Result + fStrLocate(edtCodDep, arrCodDep, 'I.ITE_CODDEP', 'CODDEP' );

    Result := Result + fStrLocate(edtUnidade, arrUnidade, 'I.ITE_CODUNI','CODUNI');
    Result := Result + fStrLocate(edtProdutos, arrProduto, 'I.ITE_CODITE','CODITE');
    Result := Result + fStrLocate(edtAbrevFis, arrAbrevFis, IfThen(fCfgSis('TIPABF') = '1', 'I', 'G') + '.ITE_CODABF','CODABF');
    Result := Result + fStrLocate(edtFornecedor, arrFornecedor, 'I.ITE_CODFOR','CODFOR');
    Result := Result + fStrLocate(edtCodEmpresa, arrEmpresa, 'G.ITE_CODEMP','CODEMP');

    If Not fEmptyStr(edtDescri.Text) Then
      Result := Result + '  AND (LOCATE(:DESITE, I.ITE_DESITE) > 0 ) ';

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      If (Not fEmptyStr(edtRefFin.Text)) Then
        Result := Result + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN '
      Else
        Result := Result + '  AND I.ITE_REFERE LIKE :REFERE ';
    End;

    If Not fEmptyStr(edtLocFis.Text) Then
      Result := Result + '  AND IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS) LIKE :LOCFIS ';
  End;
end;

procedure pSetParametros(recPar : TParPosicaoEstDataThread; qryDados: TUniQuery);
begin
  With qryDados, recPar Do
  Begin

    If Not fEmptyStr(mskLinGruSim.Text) Then
      pSetaParam(mskLinGruSim.Text, arrLinhaSim, strGruSim,'GRUSIM', qryDados);

    If Not fEmptyStr(mskLinGruNao.Text) Then
      pSetaParam(mskLinGruNao.Text, arrLinhaNao, strGruNao,'GRUNAO', qryDados);

    pSetaParam(edtMarca.Text,arrMarca, strLinMar, 'CODMAR', qryDados);

    pSetaParam(edtCodDep.Text,arrCodDep, strCodDep, 'CODDEP', qryDados);

    pSetaParam(edtUnidade.Text,arrUnidade, strLinUni, 'CODUNI', qryDados);
    pSetaParam(edtProdutos.Text,arrProduto, strLinPro, 'CODITE', qryDados);
    pSetaParam(edtAbrevFis.Text,arrAbrevFis, strLinAbre, 'CODABF', qryDados);
    pSetaParam(edtFornecedor.Text,arrFornecedor, strLinFor, 'CODFOR', qryDados);
    pSetaParam(edtCodEmpresa.Text,arrEmpresa, strLinEmp, 'CODEMP', qryDados);
    pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'GRUCMP', qryDados);

    If Not fEmptyStr(edtDescri.Text) Then
      ParamByName('DESITE').AsString := edtDescri.Text;

    If Not fEmptyStr(edtLocFis.Text) Then
      ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      If (Not fEmptyStr(edtRefFin.Text)) Then
      Begin
        ParamByName('REFERE').AsString := edtRefere.Text;
        ParamByName('REFFIN').AsString := edtRefFin.Text;

        If Length(edtRefere.Text) > Length(edtRefFin.Text) Then
          ParamByName('MAIOR').AsString := edtRefere.Text
        Else
          ParamByName('MAIOR').AsString := edtRefFin.Text;
      End
      Else
        ParamByName('REFERE').AsString := edtRefere.Text + '%';
    End;

  End;

end;

Function fSQLPrecoCusto(recPar : TParPosicaoEstDataThread; strAlias: String): String;
Begin
  With recPar Do
  Begin
    Case cbxTipPre.ItemIndex Of
      0: Result := 'ITE_PRECUS ';
      1: Result := '(IFNULL(ITE_PRECUS, 0) + IFNULL(ITE_OUTVAL, 0)) / (1 - ((IFNULL(ITE_ICMSAI, 0) + IFNULL(ITE_IMPFED, 0) + IFNULL(ITE_DESOPE, 0)) / 100))';
      2: Result := 'ITE_PREMED ';
      3: Result := 'ITE_PREULT ';
      4: Begin
           Result := Result + '(ROUND(ITE_PRECOM * ';
           Result := Result + '      (1 - IFNULL(ITE_DESF01, 0) / 100) *';
           Result := Result + '      (1 - IFNULL(ITE_DESF02, 0) / 100) *';
           Result := Result + '      (1 - IFNULL(ITE_DESF03, 0) / 100) *';
           Result := Result + '      (1 - IFNULL(ITE_DESF04, 0) / 100) *';
           Result := Result + '      (1 - IFNULL(ITE_DESF05, 0) / 100) *';
           Result := Result + '      (1 - IFNULL(ITE_DESF06, 0) / 100) ,3))';
         End;
     5: Result := ' ITE_IMPULT ';
    End;
  End;

  Result := ' (' + AnsiReplaceStr(Result, 'ITE_', strAlias + '.ITE_') + ') ';
End;


end.
