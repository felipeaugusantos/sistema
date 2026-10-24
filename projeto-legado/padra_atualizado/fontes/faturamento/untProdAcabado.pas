unit untProdAcabado;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, ComCtrls, Forms, cxProgressBar,
{$ENDIF}
  SysUtils, Classes, Uni, DB, StrUtils, Math, untIExecutaSQLReplicacaoTinta,
  System.Generics.Collections;

Type
  TValoresProdutoAcabado = record
    fltPreVe1 : Double;
    fltPreVe2 : Double;
    fltPreVe3 : Double;
    fltPreVe4 : Double;
    fltPreVe5 : Double;
    fltPreVe6 : Double;
    fltPreVe7 : Double;
    fltSaldo : Double;
  End;

  TProdAcabado = class(TCollection)
  private
    FCodAca: String;
    FCodEmp: String;
    FDescri: String;
    FIdePro: String;
    FCodBar: String;
    FCodIte: String;
    FOprFlj: String;
    FQtdPro: Double;
    FPreMed: Double;
    FPreUlt: Double;
    FImpUlt: Double;
    FComLiq: Double;
    arrTabPrecos: Array of Double;

    FOutVal: Double;
    FIcmSai: Double;
    FImpFed: Double;
    FDesOpe: Double;
    FEspDoc: String;

    //CFG_CODTIN = 3 (Código único do tintométrico)
    FUniTin: Integer;
    FBrinde: String;

    class function fSQLAca: String;
    class procedure pAlimentaProdAcabado(qryDataset: TDataSet; objProdAcabado: TProdAcabado);
    function fGeraCodigoBarras: String;
    function GetfltPreco(index: Integer): Double;
    procedure SetfltPreco(index: Integer; const Value: Double);
    function fGeraCadAcaUniTin: Integer;

    function fExisteCodigoAcabado(strCodAca, strCodEmp : String) : boolean;
    function fFloatToStrSafe(const fltValor : Double) : String;
  public
    Constructor Create; reintroduce; overload;
    Constructor Create(fltPreCus, fltPreVen: Double); overload;
    property strCodAca: String Read FCodAca;
    property strCodEmp: String Read FCodEmp;
    property strDescri: String Read FDescri Write FDescri;
    property strIdePro: String Read FIdePro Write FIdePro;
    property strCodBar: String Read FCodBar;
    property strCodIte: String Read FCodIte Write FCodIte;
    property strOprFlj: String Read FOprFlj Write FOprFlj;
    property fltQtdPro: Double Read FQtdPro Write FQtdPro;
    property fltPreco[index : Integer]: Double read GetfltPreco write SetfltPreco;
    property strEspDoc: String Read FEspDoc Write FEspDoc;
    property strUniTin: Integer Read FUniTin;
    property strBrinde: String Read FBrinde Write FBrinde;

    procedure pImportarTabelasPreco(dicRetorno: TDicionario);



    procedure pSalvar(const blnSalvarEmLote : Boolean = False);
    function fInsertIntoFieldsAcaGer : String;
    class function fBuscaPorCodigo(strCodAca: String): TProdAcabado;
    class function fBuscaPorCodBar(strCodBar: String): TProdAcabado;
    class function fAtualizaEstoque(strCodAca,
                                    strEmpAca,
                                    strCodEmp,
                                    strEntSai: String;
                                    fltQtdIte: Double;
                                    objRepTin: IExecutaSQLReplicacaoTinta = Nil): Boolean;

    class function fAtualizaLocFis(strCodAca,
                                   strEmpAca,
                                   strCodEmp,
                                   strLocFis: String): Boolean;


    class function fRetornaSaldo(strCodAca, strCodEmp, strEmpEst: String): Double;

    class procedure pGeraProdutosAcabadosLoja(strNumLoj: String;
      pgbProgresso: TcxProgressBar);

    class function fRetPreven(strCodIte, strCodEmp, strTabPre: String): Double;
    class function fValoresAcabado(const strCodAca, strEmpAca, strEmpEst: String;
      fltPrvTin: Double): TValoresProdutoAcabado;
  End;

Type
  TProdAcabadoGer = class(TCollectionItem)
    private
      FEmpEst: String;
      FSaldos: Double;
      FPreCus: Double;
      FPreVen: Double;
      FPreMed: Double;
      FPreUlt: Double;
      FImpUlt: Double;

      FOutVal: Double;
      FIcmSai: Double;
      FImpFed: Double;
      FDesOpe: Double;

      FComLiq: Double;
      FBrinde: String;
    protected
      FNovo: Boolean;
    public
      Constructor Create(Collection: TCollection); override;
      property strEmpEst: String Read FEmpEst;
      property fltSaldos: Double Read FSaldos Write FSaldos;
      property fltPreCus: Double Read FPreCus Write FPreCus;
      property fltPreVen: Double Read FPreVen Write FPreVen;
      property fltPreMed: Double read FPreMed write FPreMed;
      property fltPreUlt: Double read FPreUlt write FPreUlt;
      property fltImpUlt: Double read FImpUlt write FImpUlt;

      property fltOutVal: Double read FOutVal write FOutVal;
      property fltIcmSai: Double read FIcmSai write FIcmSai;
      property fltImpFed: Double read FImpFed write FImpFed;
      property fltDesOpe: Double read FDesOpe write FDesOpe;

      property fltComLiq: Double read FComLiq write FComLiq;
      property strBrinde: String read FBrinde write FBrinde;
      procedure pSalvar;
  End;

  TProdAcabadoHelper = class helper for TProdAcabado
    procedure pSalvarLote(const objLista : TList<TProdAcabadoGer>);
  End;

implementation



{ TProdAcabado }

constructor TProdAcabado.Create(fltPreCus, fltPreVen: Double);
var
  qryAux: TUniQuery;
  objProdAcabadoGer: TProdAcabadoGer;
begin
  pAtuTabPrc;
  inherited Create(TProdAcabadoGer);
  SetLength(arrTabPrecos, Length(VS_strTabVen));

  strOprFlj := '';
  fltQtdPro := 0.0;
  strEspDoc := '';
  strBrinde := 'N';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT EMP_CODEMP FROM CADEMP');
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    objProdAcabadoGer := TProdAcabadoGer(Self.Add);
    objProdAcabadoGer.FEmpEst   := qryAux.FieldByName('EMP_CODEMP').AsString;
    objProdAcabadoGer.fltSaldos := 0.0;
    objProdAcabadoGer.fltPreCus := fltPreCus;
    objProdAcabadoGer.fltPreVen := fltPreVen;

    qryAux.Next;
  End;

  qryAux.Close;
  FreeAndNil(qryAux);

end;

constructor TProdAcabado.Create;
begin
  pAtuTabPrc;
  inherited Create(TProdAcabadoGer);
  SetLength(arrTabPrecos, Length(VS_strTabVen));
end;

class function TProdAcabado.fAtualizaEstoque(strCodAca,
                                             strEmpAca,
                                             strCodEmp,
                                             strEntSai: String;
                                             fltQtdIte: Double;
                                             objRepTin: IExecutaSQLReplicacaoTinta = Nil): Boolean;
  Const
    SQL = 'UPDATE     '+
          '  ACAGER G '+
          'SET        '+
          '  G.ACA_SALDOS = G.ACA_SALDOS + :QTDITE '+
          'WHERE                                   '+
          '  G.ACA_CODACA = :CODACA AND '+
          '  G.ACA_CODEMP = :CODEMP AND '+
          '  G.ACA_EMPEST = :EMPEST     ';

  Var
    qryAux: TUniQuery;
    fltQtd: Double;
begin

  Result := True;
  fltQtd := fltQtdIte * IIF(strEntSai = 'E', 1, -1);

  Try

    If Assigned(objRepTin) Then
    Begin
      objRepTin.pExecutaSQL(SQL, ['QTDITE', 'CODACA', 'CODEMP', 'EMPEST'], [fltQtd, strCodAca, strEmpAca, strCodEmp]);
      Exit;
    End;

    qryAux := fCriaQuery(Nil);

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(SQL);
      qryAux.ParamByName('QTDITE').AsFloat  := fltQtd;
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('CODEMP').AsString := strEmpAca;
      qryAux.ParamByName('EMPEST').AsString := strCodEmp;
      qryAux.ExecSQL;

    Finally
      FreeAndNil(qryAux);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaEstoque]');
    End;
  End;

end;


class function TProdAcabado.fAtualizaLocFis(strCodAca,
                                            strEmpAca,
                                            strCodEmp,
                                            strLocFis: String): Boolean;
  Const
    SQL = 'UPDATE     '+
          '  ACAGER G '+
          'SET        '+
          '  G.ACA_LOCFIS = :LOCFIS '+
          'WHERE                                   '+
          '  G.ACA_CODACA = :CODACA AND '+
          '  G.ACA_CODEMP = :CODEMP AND '+
          '  G.ACA_EMPEST = :EMPEST     ';

  Var
    qryAux: TUniQuery;
begin

  Result := True;

  Try

    qryAux := fCriaQuery(Nil);

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(SQL);
      qryAux.ParamByName('LOCFIS').AsString := strLocFis;
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('CODEMP').AsString := strEmpAca;
      qryAux.ParamByName('EMPEST').AsString := strCodEmp;
      qryAux.ExecSQL;

    Finally
      FreeAndNil(qryAux);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaLocFis]');
    End;
  End;

end;


class function TProdAcabado.fBuscaPorCodBar(
  strCodBar: String): TProdAcabado;
  Var
    qryAux: TUniQuery;
begin

  Result := Nil;
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add(fSQLAca);
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ACA_CODBAR = :CODBAR ');

  qryAux.ParamByName('CODBAR').AsString := strCodBar;
  qryAux.Open;

  pAlimentaProdAcabado(qryAux, Result);

  FreeAndNil(qryAux);
end;

class function TProdAcabado.fBuscaPorCodigo(
  strCodAca: String): TProdAcabado;
  Var
    qryAux: TUniQuery;
begin

  Result := Nil;
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add(fSQLAca);
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ACA_CODACA = :CODACA ');

  qryAux.ParamByName('CODACA').AsString := strCodAca;
  qryAux.Open;

  pAlimentaProdAcabado(qryAux, Result);

  FreeAndNil(qryAux);

end;

function TProdAcabado.fExisteCodigoAcabado(strCodAca, strCodEmp : String): boolean;
Var
  qryAux: TUniQuery;
begin
  try
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Text := 'SELECT ACA_CODACA'+
                       '   FROM CADACA'+
                       '  WHERE ACA_CODACA = :CODACA'+
                       '    AND ACA_CODEMP = :CODEMP';
    qryAux.ParamByName('CODACA').AsString := strCodAca;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    Result := Not fEmptyStr(qryAux.FieldByName('ACA_CODACA').AsString);

  finally
    FreeAndNil(qryAux);
  end;

end;


function TProdAcabado.fGeraCadAcaUniTin: Integer;
 Var
    qryUniTin: TUniQuery;
begin
  Try
    qryUniTin := fCriaQuery(Nil);
    With qryUniTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ACA_UNITIN ');
      SQL.Add('  FROM CADACA     ');
      SQL.Add(' WHERE ACA_IDEPRO = :IDEPRO    ');
      SQL.Add('   AND ACA_CODEMP = :CODEMP    ');
      SQL.Add('   AND ACA_DESCRI = :DESCRI    ');
      SQL.Add('   AND ACA_UNITIN IS NOT NULL  ');
      SQL.Add('   LIMIT 1                     ');
      ParamByName('IDEPRO').AsString := FIdePro;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('DESCRI').AsString := FDescri;
      Open;

      Result := FieldByName('ACA_UNITIN').AsInteger;

      If Result <= 0 Then
      Begin
        Result := fCfgSisL('UNITIN', varInteger);
        fAtuCfgSis('UNITIN', IntToStr(Result + 1));
      End;
    End;
  Finally
    FreeAndNil(qryUniTin);
  End;
end;

{*****************************************}
{* RETORNA O SEQUENCIAL  DO CFG_PROCDB   *}
{**************************************JB*}
function TProdAcabado.fGeraCodigoBarras: String;
  Var
    intProCdb: Integer;
begin
  intProCdb := fCfgSisL('PROCDB', varInteger);

  If fCfgSis('TIPBAR') = '2' Then
  Begin
    Result := fGeraCodBarraEAN39('9' + RightStr(VS_strCodEmp, 1) + fStrZero(IntToStr(intProCdb), 6));
    fAtuCfgSis('PROCDB', IntToStr(intProCdb + 1));
  End Else
  Begin
    If intProCdb > 99999 Then
      intProCdb := 1;

    Result := '9' + FormatDateTime('yymm', VS_Date) + RightStr(VS_strCodEmp, 2) + fStrZero(intProCdb, 5);
    Result := fGeraCodBarraEAN13(Result);

    If intProCdb = 99999 Then
      fAtuCfgSis('PROCDB', '1')
    Else
      fAtuCfgSis('PROCDB', IntToStr(intProCdb + 1));
  End;
end;

class function TProdAcabado.fRetornaSaldo(strCodAca, strCodEmp,
  strEmpEst: String): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  ACA_SALDOS ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ACAGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ACA_CODACA = :CODACA AND ');
  qryAux.SQL.Add('  ACA_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  ACA_EMPEST = :EMPEST ');

  qryAux.ParamByName('CODACA').AsString := strCodAca;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('EMPEST').AsString := strEmpEst;

  qryAux.Open;
  Result := qryAux.FieldByName('ACA_SALDOS').AsFloat;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

class function TProdAcabado.fRetPreven(strCodIte, strCodEmp,
  strTabPre: String): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_PREVE' + strTabPre + ' FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.Open;

  Result := qryGen.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
  FreeAndNil(qryGen);
end;

class function TProdAcabado.fSQLAca: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  A.ACA_CODACA, ';
  Result := Result + '  A.ACA_CODEMP, ';
  Result := Result + '  A.ACA_DESCRI, ';
  Result := Result + '  A.ACA_IDEPRO, ';
  Result := Result + '  A.ACA_CODBAR, ';
  Result := Result + '  A.ACA_UNITIN, ';
  Result := Result + '  G.ACA_EMPEST, ';
  Result := Result + '  G.ACA_SALDOS, ';
  Result := Result + '  G.ACA_PRECUS, ';
  Result := Result + '  G.ACA_PREVEN ';
  Result := Result + 'FROM ';
  Result := Result + '  CADACA ';
  Result := Result + '  JOIN ACAGER ON A.ACA_CODACA = G.ACA_CODACA AND ';
  Result := Result + '                 A.ACA_CODEMP = G.ACA_CODEMP ';
end;

class function TProdAcabado.fValoresAcabado(const strCodAca, strEmpAca,
  strEmpEst: String; fltPrvTin: Double): TValoresProdutoAcabado;
  var
    qryAca : TUniQuery;
begin
  qryAca := fCriaQuery(Nil);
  Try
    FillChar(Result, SizeOf(Result), #0);
    qryAca.Close;
    qryAca.SQL.Clear;
    qryAca.SQL.Add('  SELECT A.ACA_PREVE1, ');
    qryAca.SQL.Add('         A.ACA_PREVE2, ');
    qryAca.SQL.Add('         A.ACA_PREVE3, ');
    qryAca.SQL.Add('         A.ACA_PREVE4, ');
    qryAca.SQL.Add('         A.ACA_PREVE5, ');
    qryAca.SQL.Add('         A.ACA_PREVE6, ');
    qryAca.SQL.Add('         A.ACA_PREVE7, ');
    qryAca.SQL.Add('         B.ACA_SALDOS  ');
    qryAca.SQL.Add('  FROM ACAGER A ');
    qryAca.SQL.Add('  LEFT JOIN ACAGER B ON A.ACA_CODACA = B.ACA_CODACA ');
    qryAca.SQL.Add('                    AND A.ACA_CODEMP = B.ACA_CODEMP ');
    qryAca.SQL.Add('                    AND B.ACA_EMPEST = :EMPEST ');
    qryAca.SQL.Add(' WHERE A.ACA_CODACA = :CODACA ');
    qryAca.SQL.Add('   AND A.ACA_CODEMP = :CODEMP ');
    qryAca.ParamByName('CODACA').AsString := strCodAca;
    qryAca.ParamByName('CODEMP').AsString := strEmpAca;
    qryAca.ParamByName('EMPEST').AsString := strEmpEst;
    qryAca.Open;
    If Not qryAca.IsEmpty Then
    Begin
      Result.fltSaldo :=  qryAca.FieldByName('ACA_SALDOS').AsFloat;
      Result.fltPreVe1 := qryAca.FieldByName('ACA_PREVE1').AsFloat;
      Result.fltPreVe2 := qryAca.FieldByName('ACA_PREVE2').AsFloat;
      Result.fltPreVe3 := qryAca.FieldByName('ACA_PREVE3').AsFloat;
      Result.fltPreVe4 := qryAca.FieldByName('ACA_PREVE4').AsFloat;
      Result.fltPreVe5 := qryAca.FieldByName('ACA_PREVE5').AsFloat;
      Result.fltPreVe6 := qryAca.FieldByName('ACA_PREVE6').AsFloat;
      Result.fltPreVe7 := qryAca.FieldByName('ACA_PREVE7').AsFloat;
    End
    Else
    Begin
      Result.fltPreVe1 := fltPrvTin;
      Result.fltPreVe2 := fltPrvTin;
      Result.fltPreVe3 := fltPrvTin;
      Result.fltPreVe4 := fltPrvTin;
      Result.fltPreVe5 := fltPrvTin;
      Result.fltPreVe6 := fltPrvTin;
      Result.fltPreVe7 := fltPrvTin;
    End;
  Finally
    FreeAndNil(qryAca);
  End;
end;

function TProdAcabado.GetfltPreco(index: Integer): Double;
begin
  Result := arrTabPrecos[index];
end;

class procedure TProdAcabado.pAlimentaProdAcabado(qryDataset: TDataSet;
  objProdAcabado: TProdAcabado);
  Var
    objProdAcabadoGer: TProdAcabadoGer;
begin
  If (Not qryDataset.IsEmpty) Then
  Begin

    objProdAcabado := TProdAcabado.Create;
    objProdAcabado.FCodAca   := qryDataset.FieldByName('ACA_CODACA').AsString;
    objProdAcabado.FCodEmp   := qryDataset.FieldByName('ACA_CODEMP').AsString;
    objProdAcabado.strDescri := qryDataset.FieldByName('ACA_DESCRI').AsString;
    objProdAcabado.strIdePro := qryDataset.FieldByName('ACA_IDEPRO').AsString;
    objProdAcabado.FCodBar   := qryDataset.FieldByName('ACA_CODBAR').AsString;
    objProdAcabado.FUniTin   := qryDataset.FieldByName('ACA_UNITIN').AsInteger;

    While (Not qryDataset.Eof) Do
    Begin
      objProdAcabadoGer := TProdAcabadoGer(objProdAcabado.Add);
      objProdAcabadoGer.FNovo     := False;
      objProdAcabadoGer.FEmpEst   := qryDataset.FieldByName('ACA_EMPEST').AsString;
      objProdAcabadoGer.fltSaldos := qryDataset.FieldByName('ACA_SALDOS').AsFloat;
      objProdAcabadoGer.fltPreCus := qryDataset.FieldByName('ACA_PRECUS').AsFloat;
      objProdAcabadoGer.fltPreVen := qryDataset.FieldByName('ACA_PREVEN').AsFloat;

      qryDataset.Next;
    End;


  End;
end;

class procedure TProdAcabado.pGeraProdutosAcabadosLoja(strNumLoj: String;
  pgbProgresso: TcxProgressBar);
  Var
    qryItens: TUniQuery;
    qryInsert: TUniQuery;
begin

  qryInsert := fCriaQuery(Nil);
  qryInsert.SQL.Add('INSERT INTO ');
  qryInsert.SQL.Add('  ACAGER ');
  qryInsert.SQL.Add('( ');
  qryInsert.SQL.Add('  ACA_CODACA, ');
  qryInsert.SQL.Add('  ACA_CODEMP, ');
  qryInsert.SQL.Add('  ACA_EMPEST, ');
  qryInsert.SQL.Add('  ACA_SALDOS, ');
  qryInsert.SQL.Add('  ACA_PRECUS, ');
  qryInsert.SQL.Add('  ACA_PREVEN, ');
  qryInsert.SQL.Add('  AUTOINCREM) ');
  qryInsert.SQL.Add('VALUES ( ');
  qryInsert.SQL.Add('  :CODACA, ');
  qryInsert.SQL.Add('  :CODEMP, ');
  qryInsert.SQL.Add('  :EMPEST, ');
  qryInsert.SQL.Add('  :SALDOS, ');
  qryInsert.SQL.Add('  :PRECUS, ');
  qryInsert.SQL.Add('  :PREVEN, ');
  qryInsert.SQL.Add('  :AUTINC) ');

  qryItens := fCriaQuery(Nil);
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  * ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  ACAGER ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  ACA_EMPEST = :EMPEST ');

  qryItens.ParamByName('EMPEST').AsString := VS_strCodEmp;
  qryItens.Open;

  pgbProgresso.Properties.Max := qryItens.RecordCount;
  pgbProgresso.Position := 0;

  While (Not qryItens.Eof) Do
  Begin

    qryInsert.ParamByName('CODACA').AsString := qryItens.FieldByName('ACA_CODACA').AsString;
    qryInsert.ParamByName('CODEMP').AsString := qryItens.FieldByName('ACA_CODEMP').AsString;
    qryInsert.ParamByName('EMPEST').AsString := strNumLoj;
    qryInsert.ParamByName('SALDOS').AsFloat  := 0.0;
    qryInsert.ParamByName('PRECUS').AsFloat  := qryItens.FieldByName('ACA_PRECUS').AsFloat;
    qryInsert.ParamByName('PREVEN').AsFloat  := qryItens.FieldByName('ACA_PREVEN').AsFloat;
    qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('ACAGER', VS_strCodEmp);
    qryInsert.ExecSQL;

    qryItens.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  qryItens.Close;

  FreeAndNil(qryItens);
  FreeAndNil(qryInsert);
end;

procedure TProdAcabado.pImportarTabelasPreco(dicRetorno: TDicionario);
  Var
    intCont: Integer;
begin
  For intCont := 0 To Length(arrTabPrecos)-1 Do
  Begin
    arrTabPrecos[intCont] := IfNull(dicRetorno['preve' + IntToStr(intCont+1)], 0);
  End;

  FPreMed := IfNull(dicRetorno['premed'], 0);
  FImpUlt := IfNull(dicRetorno['impult'], 0);
  FPreUlt := IfNull(dicRetorno['preult'], 0);

  FOutVal := IfNull(dicRetorno['outval'], 0);
  FIcmSai := IfNull(dicRetorno['icmsai'], 0);
  FImpFed := IfNull(dicRetorno['impfed'], 0);
  FDesOpe := IfNull(dicRetorno['desope'], 0);

  FComLiq := IfNull(dicRetorno['prctin'], 0);
end;

procedure TProdAcabado.pSalvar(const blnSalvarEmLote : Boolean = False);
  Var
    qryAux: TUniQuery;
    intContador: Integer;
    objProdAcabadoGer: TProdAcabadoGer;
    objListAcaGer : TList<TProdAcabadoGer>;
begin

  Try
    qryAux := fCriaQuery(Nil);

    If fEmptyStr(FCodAca) Then
    Begin
      qryAux.SQL.Add('INSERT INTO ');
      qryAux.SQL.Add('  CADACA ');
      qryAux.SQL.Add('( ');
      qryAux.SQL.Add('  ACA_CODACA, ');
      qryAux.SQL.Add('  ACA_CODEMP, ');
      qryAux.SQL.Add('  ACA_DESCRI, ');
      qryAux.SQL.Add('  ACA_IDEPRO, ');
      qryAux.SQL.Add('  ACA_CODBAR, ');
      qryAux.SQL.Add('  ACA_CODITE, ');
      qryAux.SQL.Add('  ACA_UNITIN, ');
      qryAux.SQL.Add('  AUTOINCREM) ');
      qryAux.SQL.Add('VALUES ( ');
      qryAux.SQL.Add('  :CODACA, ');
      qryAux.SQL.Add('  :CODEMP, ');
      qryAux.SQL.Add('  :DESCRI, ');
      qryAux.SQL.Add('  :IDEPRO, ');
      qryAux.SQL.Add('  :CODBAR, ');
      qryAux.SQL.Add('  :CODITE, ');
      qryAux.SQL.Add('  :UNITIN, ');
      qryAux.SQL.Add('  :AUTINC) ');

      If fCfgSis('SISACA') = '1' Then
        FCodAca := fAtualizaProCod('CADACA', 'ACA_CODACA')
      else
      begin
        Repeat
          FCodAca := fRetSequencial('SEQACA', VS_strCodEmp, 6);
        Until Not fExisteCodigoAcabado(FCodAca, VS_strCodEmp);
      end;


      FCodEmp := VS_strCodEmp;
      FCodBar := fGeraCodigoBarras;
      FUniTin := fGeraCadAcaUniTin;

      qryAux.ParamByName('CODACA').AsString := FCodAca;
      qryAux.ParamByName('CODEMP').AsString := FCodEmp;
      qryAux.ParamByName('DESCRI').AsString := Copy(FDescri, 1, 75);
      qryAux.ParamByName('IDEPRO').AsString := FIdePro;
      qryAux.ParamByName('CODBAR').AsString := FCodBar;
      qryAux.ParamByName('CODITE').AsString := FCodIte;
      qryAux.ParamByName('UNITIN').AsInteger := FUniTin;
      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADACA', VS_strCodEmp);

      qryAux.ExecSQL;
      qryAux.Close;

    End;

    FreeAndNil(qryAux);

    objListAcaGer := TList<TProdAcabadoGer>.Create;
    Try
      For intContador := 0 To Self.Count-1 Do
      Begin
        objProdAcabadoGer := TProdAcabadoGer(Self.Items[intContador]);

        {*****************************************}
        {* SE FOR ORDEM DE PRODUÇÃO FORA DA LOJA,*}
        {* O PROD. ACABADO COMEÇA COM ESTOQUE    *}
        {* NEGATIVO.                             *}
        {**************************************MV*}
        If (strOprFlj = 'S')                            And
           (objProdAcabadoGer.strEmpEst = VS_strCodEmp) Then
        Begin
          objProdAcabadoGer.fltSaldos := -fltQtdPro;
        End
        {******************************************}
        {* SE FOR ORDEM DE PRODUÇÃO AVULSA DE     *}
        {* PRODUTOS TINTOMÉTRICOS O PROD. ACABADO *}
        {* COMEÇA COM ESTOQUE POSITIVO,           *}
        {* POIS ESTE SERÁ UMA TINTA DE PRATELEIRA *}
        {***************************************AC*}
        Else If (strEspDoc = 'PA') And
                (objProdAcabadoGer.strEmpEst = VS_strCodEmp) Then
        Begin
          objProdAcabadoGer.fltSaldos := fltQtdPro;
        End;

        objProdAcabadoGer.fltPreMed := FPreMed;
        objProdAcabadoGer.fltImpUlt := FImpUlt;
        objProdAcabadoGer.fltPreUlt := FPreUlt;
        objProdAcabadoGer.fltOutVal := FOutVal;
        objProdAcabadoGer.fltIcmSai := FIcmSai;
        objProdAcabadoGer.fltImpFed := FImpFed;
        objProdAcabadoGer.fltDesOpe := FDesOpe;
        objProdAcabadoGer.fltComLiq := FComLiq;
        objProdAcabadoGer.strBrinde := FBrinde;

        If (blnSalvarEmLote) And (objProdAcabadoGer.FNovo) Then
          objListAcaGer.Add(objProdAcabadoGer)
        Else
          objProdAcabadoGer.pSalvar;
      End;

      If (blnSalvarEmLote) Then
        pSalvarLote(objListAcaGer);
    Finally
      FreeAndNil(objListAcaGer);
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TProdAcabado.SetfltPreco(index: Integer; const Value: Double);
begin
  arrTabPrecos[Index] := Value;
end;

function TProdAcabado.fFloatToStrSafe(const fltValor: Double): String;
begin
  Result := ReplaceStr(FloatToStr(fltValor), ',', '.');
end;

function TProdAcabado.fInsertIntoFieldsAcaGer: String;
  Var
    intCont : Integer;
begin
  Result := '';
  Result := Result + ' INSERT INTO ACAGER ';
  Result := Result + ' ( ACA_CODACA, ACA_CODEMP, ACA_EMPEST, ACA_SALDOS, ACA_PRECUS, ';
  Result := Result + '   ACA_PREVEN, ACA_PREMED, ACA_PREULT, ACA_IMPULT, ACA_OUTVAL, ';
  Result := Result + '   ACA_ICMSAI, ACA_IMPFED, ACA_DESOPE, ACA_COMLIQ, ';
  For intCont := 1 To Length(VS_strTabVen) Do
    Result := Result + ' ACA_PREVE' + IntToStr(intCont)+ ', ';
  Result := Result + '   AUTOINCREM ';
  Result := Result + ' ) ';
end;

{ TProdAcabadoGer }

constructor TProdAcabadoGer.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FNovo := True;
  FBrinde := 'N';
end;

procedure TProdAcabadoGer.pSalvar;
var
  qryAux: TUniQuery;
  objProdAcabado: TProdAcabado;
  intCont: Integer;
begin
  qryAux := fCriaQuery(Nil);
  Try
    Try
      objProdAcabado := TProdAcabado(Self.Collection);
      pAtuTabPrc;

      If FPreCus = 0 Then
        Raise Exception.Create('O preço de custo do produto acabado: '+objProdAcabado.strCodAca+
                               ' está zerado. Verifique o cadastro dos itens que compõe essa tinta!');

      If (FBrinde <> 'S') And (FPreVen = 0) Then
        Raise Exception.Create('O preço de venda do produto acabado: '+objProdAcabado.strCodAca+
                               ' está zerado. Verifique o cadastro dos itens que compõe essa tinta!');

      If FNovo Then
      Begin
        qryAux.SQL.Add(objProdAcabado.fInsertIntoFieldsAcaGer);
        qryAux.SQL.Add('VALUES ( ');
        qryAux.SQL.Add('  :CODACA, ');
        qryAux.SQL.Add('  :CODEMP, ');
        qryAux.SQL.Add('  :EMPEST, ');
        qryAux.SQL.Add('  :SALDOS, ');
        qryAux.SQL.Add('  :PRECUS, ');
        qryAux.SQL.Add('  :PREVEN, ');
        qryAux.SQL.Add('  :PREMED, ');
        qryAux.SQL.Add('  :PREULT, ');
        qryAux.SQL.Add('  :IMPULT, ');

        qryAux.SQL.Add('  :OUTVAL, ');
        qryAux.SQL.Add('  :ICMSAI, ');
        qryAux.SQL.Add('  :IMPFED, ');
        qryAux.SQL.Add('  :DESOPE, ');

        qryAux.SQL.Add('  :COMLIQ, ');

        For intCont := 1 To Length(VS_strTabVen) Do
        Begin
          qryAux.SQL.Add('  :PREVE' + IntToStr(intCont)+ ', ');
        End;

        qryAux.SQL.Add('  :AUTINC) ');

        qryAux.ParamByName('CODACA').AsString := objProdAcabado.strCodAca;
        qryAux.ParamByName('CODEMP').AsString := objProdAcabado.strCodEmp;
        qryAux.ParamByName('EMPEST').AsString := FEmpEst;
        qryAux.ParamByName('SALDOS').AsFloat  := FSaldos;
        qryAux.ParamByName('PRECUS').AsFloat  := FPreCus;
        qryAux.ParamByName('PREVEN').AsFloat  := FPreVen;
        qryAux.ParamByName('PREMED').AsFloat  := FPreMed;
        qryAux.ParamByName('PREULT').AsFloat  := FPreUlt;
        qryAux.ParamByName('IMPULT').AsFloat  := FImpUlt;

        qryAux.ParamByName('OUTVAL').AsFloat  := FOutVal;
        qryAux.ParamByName('ICMSAI').AsFloat  := FIcmSai;
        qryAux.ParamByName('IMPFED').AsFloat  := FImpFed;
        qryAux.ParamByName('DESOPE').AsFloat  := FDesOpe;

        qryAux.ParamByName('COMLIQ').AsFloat  := FComLiq;

        For intCont := 1 To Length(VS_strTabVen) Do
        Begin
          qryAux.ParamByName('PREVE' + IntToStr(intCont)).AsFloat  :=
            IfThen(objProdAcabado.fltPreco[intCont - 1] <= 0, FPreVen, objProdAcabado.fltPreco[intCont - 1]);
        End;

        qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('ACAGER', VS_strCodEmp);

        qryAux.ExecSQL;
        qryAux.Close;
      End
      Else
      Begin
        qryAux.SQL.Add('UPDATE ');
        qryAux.SQL.Add('  ACAGER ');
        qryAux.SQL.Add('SET ');
        qryAux.SQL.Add('  ACA_SALDOS = :SALDOS, ');
        qryAux.SQL.Add('  ACA_PRECUS = :PRECUS, ');


        For intCont := 1 To Length(VS_strTabVen) Do
        Begin
          qryAux.SQL.Add('  ACA_PREVE' + IntToStr(intCont) + ' = :PREVE' + IntToStr(intCont) + ', ');
        End;

        qryAux.SQL.Add('  ACA_PREVEN = :PREVEN, ');
        qryAux.SQL.Add('  ACA_PREMED = :PREMED, ');
        qryAux.SQL.Add('  ACA_PREULT = :PREULT, ');
        qryAux.SQL.Add('  ACA_IMPULT = :IMPULT, ');
        qryAux.SQL.Add('  ACA_COMLIQ = :COMLIQ  ');

        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  ACA_EMPEST = :EMPEST AND ');
        qryAux.SQL.Add('  ACA_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('  ACA_CODACA = :CODACA ');

        qryAux.ParamByName('CODACA').AsString := objProdAcabado.strCodAca;
        qryAux.ParamByName('CODEMP').AsString := objProdAcabado.strCodEmp;
        qryAux.ParamByName('EMPEST').AsString := FEmpEst;
        qryAux.ParamByName('SALDOS').AsFloat  := FSaldos;
        qryAux.ParamByName('PRECUS').AsFloat  := FPreCus;

        For intCont := 1 To Length(VS_strTabVen) Do
        Begin
          qryAux.ParamByName('PREVE'+IntToStr(intCont)).AsFloat  := objProdAcabado.fltPreco[intCont - 1];
        End;

        qryAux.ParamByName('PREVEN').AsFloat  := FPreVen;

        qryAux.ParamByName('PREMED').AsFloat  := FPreMed;
        qryAux.ParamByName('PREULT').AsFloat  := FPreUlt;
        qryAux.ParamByName('IMPULT').AsFloat  := FImpUlt;
        qryAux.ParamByName('COMLIQ').AsFloat  := FComLiq;

        qryAux.ExecSQL;
        qryAux.Close;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{ TProdAcabadoHelper }

procedure TProdAcabadoHelper.pSalvarLote(const objLista: TList<TProdAcabadoGer>);
  Var
    objItem : TProdAcabadoGer;
    strInsertInto : String;
    strValues : String;
    intCont : Integer;
    strAutoincrem : String;
    qryAcaGer : TUniQuery;
    objProdAcabado : TProdAcabado;
begin
  If objLista.Count = 0 Then
    Exit;

  strInsertInto := Self.fInsertIntoFieldsAcaGer + ' VALUES ';
  strValues := '';

  strAutoincrem := fRetAutoIncrem('ACAGER', VS_strCodEmp, objLista.Count);

  For objItem In objLista Do
  Begin
    objProdAcabado := TProdAcabado(objItem.Collection);
    pAtuTabPrc;

    If objItem.FPreCus = 0 Then
      Raise Exception.Create('O preço de custo do produto acabado: '+objProdAcabado.strCodAca+
                             ' está zerado. Verifique o cadastro dos itens que compõe essa tinta!');

    If (objItem.FBrinde <> 'S') And (objItem.FPreVen = 0) Then
      Raise Exception.Create('O preço de venda do produto acabado: '+objProdAcabado.strCodAca+
                             ' está zerado. Verifique o cadastro dos itens que compõe essa tinta!');

    If Not fEmptyStr(strValues) Then
      strValues := strValues + ',';

    strValues := strValues + '(';
    strValues := strValues +    QuotedStr(objProdAcabado.strCodAca) + ',';
    strValues := strValues +    QuotedStr(objProdAcabado.strCodEmp) + ',';
    strValues := strValues +    QuotedStr(objItem.FEmpEst) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FSaldos) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FPreCus) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FPreVen) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FPreMed) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FPreUlt) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FImpUlt) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FOutVal) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FIcmSai) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FImpFed) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FDesOpe) + ',';
    strValues := strValues +    fFloatToStrSafe(objItem.FComLiq) + ',';
    For intCont := 1 To Length(VS_strTabVen) Do
      strValues := strValues +  fFloatToStrSafe(IfThen(objProdAcabado.fltPreco[intCont - 1] <= 0, objItem.FPreVen, objProdAcabado.fltPreco[intCont - 1])) + ',';
    strValues := strValues +    QuotedStr(strAutoincrem);
    strValues := strValues + ')';
    strAutoincrem := fNextAutoIncrem(strAutoincrem);
  End;

  qryAcaGer := fCriaQuery;
  Try
    qryAcaGer.Close;
    qryAcaGer.SQL.Clear;
    qryAcaGer.SQL.Add(strInsertInto + strValues);
    qryAcaGer.ExecSQL;
  Finally
    FreeAndNil(qryAcaGer);
  End;
end;

end.
