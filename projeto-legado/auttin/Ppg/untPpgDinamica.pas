unit untPpgDinamica;

interface

uses
  untTintadeMaquina, Classes, Uni, untIConfTinta, ComObj,
  UniClientDataSet, DB, Forms, StrUtils;

Type
  TPpgOpcao = (TPpgGeraBases, TPpgGeraTintas);
  TPpgOpcoes = set of TPpgOpcao;

  TPpgAutomotivaDinamica = class(TTintadeMaquina)
  private
    strPat: String;
    FOpcoes: TPpgOpcoes;
    conf: IConfTinta;

    cdstblCOLOR      : TUniClientDataSet;
    qryCODE          : TUniQuery;
    qryVEHICLE       : TUniQuery;
    cdstblPART       : TUniClientDataSet;
    qryVARIANT       : TUniQuery;
    qryMATCH         : TUniQuery;
    qryLAYER         : TUniQuery;
    qryTINTDETAIL    : TUniQuery;
    cdstblBASIC      : TUniClientDataSet;
    cdstblUSEDBASIC  : TUniClientDataSet;
    cdstblLOOKUP     : TUniClientDataSet;
    qrySOURCE        : TUniQuery;

    function fProcessaCadBas: Boolean;
    function fProcessaCadPpg: Boolean;
    function fProcessaRegrasDiluicao: Boolean;
    function fProcessaCadBasNovo: Boolean;
    function fProcessaCadPpgNovo: Boolean;
    function fGetDescriVariant(strVariant: string): string;

    function fContaLinhas(strNomArq: String): Integer;
    function fProximoSeq(): Integer;

    function fGetStringPipe(strLinha: String; intPosicao: Integer): Variant;

    function fRetornaVeiculo: String;

    function fFormataStringFloat(strValor: String; intDecimal: Integer): Double;

    function fRetornaReferencia(strStatus: String): String;

    function fBasePodeGravar(strCodBas: String): Boolean;

    procedure pPreencheClientDataSetBases(stlNomArq: TStringList);
    procedure pPreencheClientDataSetFormulas(stlNomArq: TStringList);

    procedure pPreencheClienttblCOLOR(strNomArq: String);
    procedure pPreencheClienttblCODE(strNomArq: String);
    procedure pPreencheClienttblVEHICLE(strNomArq: String);
    procedure pPreencheClienttblVARIANT(strNomArq: String);
    procedure pPreencheClienttblMATCH(strNomArq: String);
    procedure pPreencheClienttblLAYER(strNomArq: String);
    procedure pPreencheClienttblTINTDETAIL(strNomArq: String);
    procedure pPreencheClienttblBASIC(strNomArq: String);
    procedure pPreencheClienttblUSEDBASIC(strNomArq: String);
    procedure pPreencheClienttblLOOKUP(strNomArq: String);
    procedure pPreencheClienttblSOUCER(strNomArq: String);

    procedure pCriaClientDataSetBases;
    procedure pCriaClientDataSetFormulas;

    procedure pCriaClienttblCOLOR;
    procedure pCriaClienttblCODE;
    procedure pCriaClienttblVEHICLE;
    procedure pCriaClienttblPART;
    procedure pCriaClienttblVARIANT;
    procedure pCriaClienttblMATCH;
    procedure pCriaClienttblLAYER;
    procedure pCriaClienttblTINTDETAIL;
    procedure pCriaClienttblBASIC;
    procedure pCriaClienttblUSEDBASIC;
    procedure pCriaClienttblLOOKUP;
    procedure pCriaClienttblSOURCE;

    procedure pDestroiClientDataSetBases;
    procedure pDestroiClientDataSetFormulas;

    procedure pDestroiClienttblCOLOR;
    procedure pDestroiClienttblCODE;
    procedure pDestroiClienttblVEHICLE;
    procedure pDestroiClienttblPART;
    procedure pDestroiClienttblVARIANT;
    procedure pDestroiClienttblMATCH;
    procedure pDestroiClienttblLAYER;
    procedure pDestroiClienttblTINTDETAIL;
    procedure pDestroiClienttblBASIC;
    procedure pDestroiClienttblUSEDBASIC;
    procedure pDestroiClienttblLOOKUP;
    procedure pDestroiClienttblSOURCE;

    procedure SetOpcoes(const Value: TPpgOpcoes);
  public
    constructor Create(AOwner: TComponent); override;
    function fProcessaArquivos: Boolean;
    function fProcessaArquivosDiluicao: Boolean;
    function fProcessaArquivosNovos: Boolean;
    class function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
    class function fRetProxCodSeq(): Integer;
    class function fDelNovaFormula(strCodNfm: String): Boolean;
    function fGravarNovasFormulas(): Boolean; override;

  published
    property Opcoes: TPpgOpcoes read FOpcoes write SetOpcoes;
  End;

implementation

uses SysUtils, untFuncoesSimples,  untFuncTinta, Variants, untDDLFactory;

{ TPpgAutomotivaDinamica }

constructor TPpgAutomotivaDinamica.Create(AOwner: TComponent);
begin
  conf      := fGetConfTinta('PPG');
  NomeTinta := 'PPG';
  strPat    := conf.fGet('PATPPG'); //fArqIniTinta(0, 'PPG', 'PATPPG', '');
end;

function TPpgAutomotivaDinamica.fContaLinhas(strNomArq: String): Integer;
var
  arqGen: TextFile;
begin
  try
    Try
      AssignFile(arqGen, strNomArq);
      Reset(arqGen);
      Result := 0;

      While Not Eof(arqGen) Do
      Begin
        Readln(arqGen);
        Result := Result + 1;
      End;

    Except
      Result := 0;
    End;
  finally
    CloseFile(arqGen);
  end;
end;

class function TPpgAutomotivaDinamica.fDelNovaFormula(
  strCodNfm: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'DELETE FROM PPG_CADPPG WHERE PPG_CODCOR = :CODCOR;';
  qryGen.ParamByName('CODCOR').AsString := strCodNfm;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
  Result := True;
end;

class function TPpgAutomotivaDinamica.fGravaNovaFormula(
  qryNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;

  function fRetVolume(strCodBas: String; fltGramas: Double): Double;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Text := 'SELECT (:QTD / BAS_PESESP) ML FROM PPG_CADBAS WHERE BAS_CODBAS = :CODBAS;';
    qryGen.ParamByName('QTD').AsFloat := fltGramas;
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;
    Result := qryGen.FieldByName('ML').AsFloat;
    FreeAndNil(qryGen);
  end;

begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Clear;

    qryGen.SQL.Text := 'DELETE FROM PPG_CADPPG WHERE PPG_CODCOR = :CODCOR;';
    qryGen.ParamByName('CODCOR').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
    qryGen.ExecSQL;
    qryGen.SQL.Clear;

    qryGen.SQL.Text := TDDLFactory.GetInsertDelayed('PPG_CADPPG');

    qryGen.ParamByName('PPG_CODSEQ').AsString := fStrZero(fRetProxCodSeq, 6);
    qryGen.ParamByName('PPG_DESCOR').AsString := qryNfm.FieldByName('NFM_DESCOR').AsString + ' ' + qryNfm.FieldByName('NFM_VARIAN').AsString;
    qryGen.ParamByName('PPG_VEICUL').AsString := qryNfm.FieldByName('NFM_VEICUL').AsString;
    qryGen.ParamByName('PPG_MONTAD').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString;
    qryGen.ParamByName('PPG_TIPO__').AsString := qryNfm.FieldByName('NFM_TIPO__').AsString;
    qryGen.ParamByName('PPG_A_N_O_').AsString := qryNfm.FieldByName('NFM_A_N_O_').AsString;
    qryGen.ParamByName('PPG_CODCOR').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
    qryGen.ParamByName('PPG_CODATC').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString + 'ESP' + qryNfm.FieldByName('NFM_VARIAN').AsString;
    qryGen.ParamByName('PPG_CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('PPG_CADPPG', VS_strCodEmp);
    qryGen.ParamByName('PPG_MARCA_').AsString := 'PPG';
    qryGen.ParamByName('PPG_SISTEM').AsString := 'PERSONALIZADA';
    qryGen.ParamByName('PPG_ORIGEM').AsString := 'PERSONALIZADA';
    qryGen.ParamByName('PPG_PAISES').AsString := 'BRASIL';
    qryGen.ParamByName('PPG_VARIAN').AsString := qryNfm.FieldByName('NFM_VARIAN').AsString;
    qryGen.ParamByName('PPG_ATIVO_').AsString := IIF(fEmptyStr(qryNfm.FieldByName('NFM_ATIVO_').AsString),'S',qryNfm.FieldByName('NFM_ATIVO_').AsString);
    qryGen.ParamByName('PPG_EFEFIN').AsString := 'PERSONALIZADA';
    qryGen.ParamByName('PPG_ACRMOB').AsString := qryNfm.FieldByName('NFM_ACRMOB').AsString;
    qryGen.ParamByName('PPG_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intCont := 1 To 20 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString) Then
        Break;

      qryGen.ParamByName('PPG_CODB' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString;
      qryGen.ParamByName('PPG_QTDB' + fStrZero(intCont, 2)).AsFloat  := qryNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat;
    End;

    qryGen.ParamByName('PPG_MD5KEY').AsString :=  GetMD5(qryGen.ParamByName('PPG_DESCOR').AsString +
                                                      qryGen.ParamByName('PPG_VEICUL').AsString +
                                                      qryGen.ParamByName('PPG_TIPO__').AsString +
                                                      qryGen.ParamByName('PPG_A_N_O_').AsString +
                                                      qryGen.ParamByName('PPG_CODCOR').AsString +
                                                      qryGen.ParamByName('PPG_CODATC').AsString +
                                                      qryGen.ParamByName('PPG_VARIAN').AsString +
                                                      qryGen.ParamByName('PPG_MARCA_').AsString +
                                                      qryGen.ParamByName('PPG_UTILIZ').AsString +
                                                      qryGen.ParamByName('PPG_SISTEM').AsString +
                                                      qryGen.ParamByName('PPG_ORIGEM').AsString +
                                                      qryGen.ParamByName('PPG_MONTAD').AsString);

    qryGen.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TPpgAutomotivaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM PPG_CADNFM';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas fórmulas...');
  While Not qryGen.Eof Do
  Begin
    fGravaNovaFormula(qryGen);
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
    qryGen.Next;
  End;
  pRegistraAcao('Cadastro de novas fórmulas realizado com sucesso!');
  FreeAndNil(qryGen);
  Result := True;
end;

function TPpgAutomotivaDinamica.fProcessaArquivos: Boolean;
begin
  Result := True;
  //(TPpgGeraBases, TPpgGeraTintas);

  If TPpgGeraBases in Opcoes Then
    Result := Result And fProcessaCadBas;

  If TPpgGeraTintas in Opcoes Then
    Result := Result And fProcessaCadPpg;
end;

function TPpgAutomotivaDinamica.fProcessaArquivosDiluicao: Boolean;
begin
  Result := fProcessaRegrasDiluicao;
end;

function TPpgAutomotivaDinamica.fProcessaCadBas: Boolean;
  Var
    arqBas    : TextFile;
    strLinha: String;

    intAtual  : Integer;
    intMax    : Integer;

    qryCadBas : TUniQuery;

    strCodBas : String;
    strTipo: String;
begin

  try
    If Not FileExists(strPat) Then
    Begin
      Result := fMensagem('', Format('O Arquivo %s não existe!', [strPat]),['OK']) = -1;
      Exit;
    End;

    intAtual := 1;
    intMax := fContaLinhas(strPat);

    AssignFile(arqBas, strPat);
    Reset(arqBas);

    qryCadBas := fCriaQuery(Self);
    qryCadBas.SQL.Text := 'SELECT * FROM PPG_CADBAS';
    qryCadBas.Open;

    pRegistraAcao('Cadastrando bases...');
    While Not Eof(arqBas) Do
    Begin
      Readln(arqBas, strLinha);

      If Length(strLinha) = 180 Then
      Begin
        strCodBas := AnsiUpperCase(Trim(Copy(strLinha, 75, 25)));

        If Not qryCadBas.Locate('BAS_CODBAS', strCodBas, []) Then
        Begin
          qryCadBas.Insert;

          qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);
          qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
          qryCadBas.FieldByName('BAS_DESBAS').AsString := AnsiUpperCase(Trim(Copy(strLinha, 33, 32)));
          qryCadBas.FieldByName('BAS_PESESP').AsFloat:= fStrToFloat(Trim(AnsiReplaceStr(Copy(strLinha, 173, 8), '.', ',')));

          strTipo := AnsiUpperCase(Trim(Copy(strLinha, 65, 10)));

          If strTipo = 'BC' Then
            strTipo := 'DELTRON BC'
          Else If strTipo = 'DG' Then
            strTipo := 'DELTRON DG'
          Else If strTipo = 'UHS' Then
            strTipo := 'DELTRON UHS';

          qryCadBas.FieldByName('BAS_TIPO__').AsString := strTipo;
          qryCadBas.Post;
        End;

        pRegistraProgresso(0, intAtual, intMax);
        intAtual := intAtual + 1;
      End;

    End;
    pRegistraAcao('Cadastro de bases realizado com sucesso!');
  finally
    CloseFile(arqBas);
    Result := True;
  end;

end;
{
function TPpgAutomotivaDinamica.fProcessaCadBasPaintManager: Boolean;
  Var
    arqBas    : TextFile;
    strLinha: String;

    intAtual  : Integer;
    intMax    : Integer;

    qryCadBas : TUniQuery;

    strCodBas : String;
    strTipo: String;

    Excel,Sheet: variant;
    intL,intC: integer;
    strPesoEsp: String;
    strPesoEmb: String;
begin

  try
    If Not FileExists(strPat) Then
    Begin
      Result := fMensagem('', Format('O Arquivo %s não existe!', [strPat]),['OK']) = -1;
      Exit;
    End;

    strPesoEsp := '';
    strPesoEmb := '';

    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := False;
    Excel.WorkBooks.Add(strPat);

    intL := 2;

    intAtual := 1;
    intMax   := 0;

    qryCadBas := fCriaQuery(Self);
    qryCadBas.SQL.Text := 'SELECT * FROM PPG_CADBAS';
    qryCadBas.Open;

    pRegistraAcao('Cadastrando bases...');

    While Excel.Cells.Item[intL,1].Value <> '' Do
    Begin

      If (Not qryCadBas.Locate('BAS_CODBAS', Excel.Cells.Item[intL,4].Value, [])) then
      Begin
        strPesoEsp := Excel.Cells.Item[intL,8].Text;
        strPesoEmb := Excel.Cells.Item[intL,6].Text;

        if Pos(' Kg',strPesoEmb) > 0 then
          strPesoEmb := Copy(strPesoEmb,1,Pos('Kg',strPesoEmb) - 1);

        if Pos(' g',strPesoEmb) > 0 then
          strPesoEmb := Copy(strPesoEmb,1,Pos('g',strPesoEmb) - 1);

        if (strPesoEsp <> 'NÃO TEM P.E') And (strPesoEsp <> '') And (Excel.Cells.Item[intL,4].Text <> '#N/D') then
        begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);
          qryCadBas.FieldByName('BAS_CODBAS').AsString := Excel.Cells.Item[intL,4].Value;
          qryCadBas.FieldByName('BAS_DESBAS').AsString := Excel.Cells.Item[intL,5].Value;
          qryCadBas.FieldByName('BAS_PESESP').AsFloat  := fStrToFloat(AnsiReplaceStr(strPesoEsp,'.',',')); //fStrToFloat(AnsiReplaceStr(Excel.Cells.Item[intL,8].Value,'.',','));
          qryCadBas.FieldByName('BAS_TIPO__').AsString := Excel.Cells.Item[intL,1].Value;
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := fStrToFloat(AnsiReplaceStr(strPesoEmb,'.',',')); //fStrToFloat(AnsiReplaceStr(Excel.Cells.Item[intL,6].Value,'.',','));
          qryCadBas.Post;
        end;
      End;

      pRegistraProgresso(0, intAtual, intMax);
      intAtual := intAtual + 1;
      intL     := intL + 1;
    End;
    pRegistraAcao('Cadastro de bases realizado com sucesso!');
  finally
    FreeAndNil(qryCadBas);
    Excel  := Unassigned;
    Result := True;
  end;
end;
}
function TPpgAutomotivaDinamica.fProcessaRegrasDiluicao: Boolean;
Var
  Excel : Variant;
  intL : Integer;
  strLinha: String;
  qryRegDil: TUniQuery;
  intAtual : Integer;
begin
  try
    If Not FileExists(strPat) Then
    Begin
      Result :=  fMensagem('', Format('O Arquivo %s não existe!', [strPat]),['OK']) = - 1;
      Exit;
    End;

    strLinha := '';

    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := False;
    Excel.WorkBooks.Add(strPat);

    intL := 3;
    intAtual := 1;

    qryRegDil := fCriaQuery(Self);
    qryRegDil.SQL.Text := 'SELECT * FROM PPG_REGDIL';
    qryRegDil.Open;

    pRegistraAcao('Cadastrando Diluentes...');

    While ((Excel.Cells.Item[intL,2].Text <> '') Or
           ((Excel.Cells.Item[intL,3].Text <> '') And
            (Excel.Cells.Item[intL,4].Text <> '') And
            (Excel.Cells.Item[intL,5].Text <> '') And
            (Excel.Cells.Item[intL,6].Text <> ''))) Do
    Begin
      if Excel.Cells.Item[intL,2].Text <> '' then
        strLinha := Excel.Cells.Item[intL,2].Text;

      if strLinha = 'GRS Deltron' then
        strLinha := 'Deltron';
      if strLinha = 'EHP ' then
        strLinha := 'ENVIROBASE';

      if ((Excel.Cells.Item[intL,3].Text <> '') And
          (Excel.Cells.Item[intL,4].Text <> '') And
          (Excel.Cells.Item[intL,5].Text <> '') And
          (Excel.Cells.Item[intL,6].Text <> '')) then
      begin
        qryRegDil.Insert;
        qryRegDil.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);
        qryRegDil.FieldByName('DIL_CODEMP').AsString := VS_strCodEmp;
        qryRegDil.FieldByName('DIL_LINHA_').AsString := strLinha;
        qryRegDil.FieldByName('DIL_SISTEM').AsString := Excel.Cells.Item[intL,3].Text;
        qryRegDil.FieldByName('DIL_CODDIL').AsString := Excel.Cells.Item[intL,4].Text;
        qryRegDil.FieldByName('DIL_DENSID').AsFloat  := Excel.Cells.Item[intL,5].Value;
        qryRegDil.FieldByName('DIL_PERDIL').AsString := Excel.Cells.Item[intL,6].Text;
        qryRegDil.Post;

        intAtual := intAtual + 1;
        pRegistraProgresso(0, intAtual, 0);
      end;
      intL := intL + 1;
    End;

  finally
    FreeAndNil(qryRegDil);
    Excel  := Unassigned;
    Result := True;
  end;
end;

function TPpgAutomotivaDinamica.fProcessaCadPpg: Boolean;
  Var
    arqPpg    : TextFile;
    strLinha: String;

    intAtual  : Integer;
    intMax    : Integer;

    qryCadPpg : TUniQuery;

    strDescricao: String;
    strCodigo: String;
    strCodPpg: String;
    strMontadora: String;
    strModelo: String;
    strVariante: String;
    strProduto: String;
    strAnoInicial: String;
    strAnoFinal: String;

    arrForm: Array[1..20] of String;
    arrQtd: Array[1..20] of Double;
    intForm: Integer;

    procedure Limpar();
    var
      i: Integer;
    Begin
      qryCadPpg.ParamByName('CODEMP').Value := Null;
      qryCadPpg.ParamByName('AUTOINCREM').Value := Null;

      qryCadPpg.ParamByName('CODSEQ').Value := Null;
      qryCadPpg.ParamByName('DESCOR').Value := Null;
      qryCadPpg.ParamByName('VEICUL').Value := Null;
      qryCadPpg.ParamByName('MONTAD').Value := Null;
      qryCadPpg.ParamByName('TIPO__').Value := Null;
      qryCadPpg.ParamByName('A_N_O_').Value := Null;
      qryCadPpg.ParamByName('CODCOR').Value := Null;
      qryCadPpg.ParamByName('CODATC').Value := Null;
      For i := 1 To 20 Do
      Begin
        arrForm[i] := '';
        arrQtd[i] := 0.0;
        qryCadPpg.ParamByName('CODB' + fStrZero(i, 2)).Value := Null;
        qryCadPpg.ParamByName('QTDB' + fStrZero(i, 2)).Value := Null;
      End;
    End;
begin

  try
    If Not FileExists(strPat) Then
    Begin
       Result :=  fMensagem('', Format('O Arquivo %s não existe!', [strPat]),['OK']) = - 1;
      Exit;
    End;

    AssignFile(arqPpg, strPat);
    Reset(arqPpg);

    qryCadPpg := fCriaQuery(Self);

    If (fMensagem('', 'Deseja limpar a tabela de tintas?', ['SIM', 'NÃO'], 2) = 1) Then
    Begin
      qryCadPpg.SQL.Text := 'TRUNCATE TABLE PPG_CADPPG';
      qryCadPpg.ExecSQL;
    End;

    intAtual := fProximoSeq;
    intMax := fContaLinhas(strPat) + fProximoSeq - 1;

    qryCadPpg.SQL.Clear;
    qryCadPpg.SQL.Add('INSERT DELAYED INTO PPG_CADPPG');
    qryCadPpg.SQL.Add('            (PPG_CODSEQ,');
    qryCadPpg.SQL.Add('             PPG_DESCOR,');
    qryCadPpg.SQL.Add('             PPG_VEICUL,');
    qryCadPpg.SQL.Add('             PPG_MONTAD,');
    qryCadPpg.SQL.Add('             PPG_TIPO__,');
    qryCadPpg.SQL.Add('             PPG_A_N_O_,');
    qryCadPpg.SQL.Add('             PPG_CODCOR,');
    qryCadPpg.SQL.Add('             PPG_CODATC,');
    qryCadPpg.SQL.Add('             PPG_PRECUS,');
    qryCadPpg.SQL.Add('             PPG_PREVEN,');
    qryCadPpg.SQL.Add('             PPG_CODEMP,');
    qryCadPpg.SQL.Add('             AUTOINCREM,');
    qryCadPpg.SQL.Add('             PPG_CODB01,');
    qryCadPpg.SQL.Add('             PPG_QTDB01,');
    qryCadPpg.SQL.Add('             PPG_CODB02,');
    qryCadPpg.SQL.Add('             PPG_QTDB02,');
    qryCadPpg.SQL.Add('             PPG_CODB03,');
    qryCadPpg.SQL.Add('             PPG_QTDB03,');
    qryCadPpg.SQL.Add('             PPG_CODB04,');
    qryCadPpg.SQL.Add('             PPG_QTDB04,');
    qryCadPpg.SQL.Add('             PPG_CODB05,');
    qryCadPpg.SQL.Add('             PPG_QTDB05,');
    qryCadPpg.SQL.Add('             PPG_CODB06,');
    qryCadPpg.SQL.Add('             PPG_QTDB06,');
    qryCadPpg.SQL.Add('             PPG_CODB07,');
    qryCadPpg.SQL.Add('             PPG_QTDB07,');
    qryCadPpg.SQL.Add('             PPG_CODB08,');
    qryCadPpg.SQL.Add('             PPG_QTDB08,');
    qryCadPpg.SQL.Add('             PPG_CODB09,');
    qryCadPpg.SQL.Add('             PPG_QTDB09,');
    qryCadPpg.SQL.Add('             PPG_CODB10,');
    qryCadPpg.SQL.Add('             PPG_QTDB10,');
    qryCadPpg.SQL.Add('             PPG_CODB11,');
    qryCadPpg.SQL.Add('             PPG_QTDB11,');
    qryCadPpg.SQL.Add('             PPG_CODB12,');
    qryCadPpg.SQL.Add('             PPG_QTDB12,');
    qryCadPpg.SQL.Add('             PPG_CODB13,');
    qryCadPpg.SQL.Add('             PPG_QTDB13,');
    qryCadPpg.SQL.Add('             PPG_CODB14,');
    qryCadPpg.SQL.Add('             PPG_QTDB14,');
    qryCadPpg.SQL.Add('             PPG_CODB15,');
    qryCadPpg.SQL.Add('             PPG_QTDB15,');
    qryCadPpg.SQL.Add('             PPG_CODB16,');
    qryCadPpg.SQL.Add('             PPG_QTDB16,');
    qryCadPpg.SQL.Add('             PPG_CODB17,');
    qryCadPpg.SQL.Add('             PPG_QTDB17,');
    qryCadPpg.SQL.Add('             PPG_CODB18,');
    qryCadPpg.SQL.Add('             PPG_QTDB18,');
    qryCadPpg.SQL.Add('             PPG_CODB19,');
    qryCadPpg.SQL.Add('             PPG_QTDB19,');
    qryCadPpg.SQL.Add('             PPG_CODB20,');
    qryCadPpg.SQL.Add('             PPG_QTDB20)');
    qryCadPpg.SQL.Add('VALUES (:CODSEQ,');
    qryCadPpg.SQL.Add('        :DESCOR,');
    qryCadPpg.SQL.Add('        :VEICUL,');
    qryCadPpg.SQL.Add('        :MONTAD,');
    qryCadPpg.SQL.Add('        :TIPO__,');
    qryCadPpg.SQL.Add('        :A_N_O_,');
    qryCadPpg.SQL.Add('        :CODCOR,');
    qryCadPpg.SQL.Add('        :CODATC,');
    qryCadPpg.SQL.Add('        :PRECUS,');
    qryCadPpg.SQL.Add('        :PREVEN,');
    qryCadPpg.SQL.Add('        :CODEMP,');
    qryCadPpg.SQL.Add('        :AUTOINCREM,');
    qryCadPpg.SQL.Add('        :CODB01,');
    qryCadPpg.SQL.Add('        :QTDB01,');
    qryCadPpg.SQL.Add('        :CODB02,');
    qryCadPpg.SQL.Add('        :QTDB02,');
    qryCadPpg.SQL.Add('        :CODB03,');
    qryCadPpg.SQL.Add('        :QTDB03,');
    qryCadPpg.SQL.Add('        :CODB04,');
    qryCadPpg.SQL.Add('        :QTDB04,');
    qryCadPpg.SQL.Add('        :CODB05,');
    qryCadPpg.SQL.Add('        :QTDB05,');
    qryCadPpg.SQL.Add('        :CODB06,');
    qryCadPpg.SQL.Add('        :QTDB06,');
    qryCadPpg.SQL.Add('        :CODB07,');
    qryCadPpg.SQL.Add('        :QTDB07,');
    qryCadPpg.SQL.Add('        :CODB08,');
    qryCadPpg.SQL.Add('        :QTDB08,');
    qryCadPpg.SQL.Add('        :CODB09,');
    qryCadPpg.SQL.Add('        :QTDB09,');
    qryCadPpg.SQL.Add('        :CODB10,');
    qryCadPpg.SQL.Add('        :QTDB10,');
    qryCadPpg.SQL.Add('        :CODB11,');
    qryCadPpg.SQL.Add('        :QTDB11,');
    qryCadPpg.SQL.Add('        :CODB12,');
    qryCadPpg.SQL.Add('        :QTDB12,');
    qryCadPpg.SQL.Add('        :CODB13,');
    qryCadPpg.SQL.Add('        :QTDB13,');
    qryCadPpg.SQL.Add('        :CODB14,');
    qryCadPpg.SQL.Add('        :QTDB14,');
    qryCadPpg.SQL.Add('        :CODB15,');
    qryCadPpg.SQL.Add('        :QTDB15,');
    qryCadPpg.SQL.Add('        :CODB16,');
    qryCadPpg.SQL.Add('        :QTDB16,');
    qryCadPpg.SQL.Add('        :CODB17,');
    qryCadPpg.SQL.Add('        :QTDB17,');
    qryCadPpg.SQL.Add('        :CODB18,');
    qryCadPpg.SQL.Add('        :QTDB18,');
    qryCadPpg.SQL.Add('        :CODB19,');
    qryCadPpg.SQL.Add('        :QTDB19,');
    qryCadPpg.SQL.Add('        :CODB20,');
    qryCadPpg.SQL.Add('        :QTDB20);');

    pRegistraAcao('Cadastrando tintas...');
    While Not Eof(arqPpg) Do
    Begin
      Readln(arqPpg, strLinha);

      If Length(strLinha) = 342 Then
      Begin

        Limpar;

        strDescricao := AnsiUpperCase(Trim(Copy(strLinha, 33, 32)));
        strCodigo    := AnsiUpperCase(Trim(Copy(strLinha, 75, 10)));
        strCodPpg    := AnsiUpperCase(Trim(Copy(strLinha, 9, 24)));
        strMontadora := AnsiUpperCase(Trim(Copy(strLinha, 4, 3)));
        strModelo    := AnsiUpperCase(Trim(Copy(strLinha, 106, 30)));
        strVariante  := AnsiUpperCase(Trim(Copy(strLinha, 85, 51)));
        strProduto   := AnsiUpperCase(Trim(Copy(strLinha, 65, 10)));
        strAnoInicial:= AnsiUpperCase(Trim(Copy(strLinha, 136, 4)));
        strAnoFinal  := AnsiUpperCase(Trim(Copy(strLinha, 140, 4)));

        arrForm[1]  := AnsiUpperCase(Trim(Copy(strLinha, 182, 10)));
        arrQtd[1]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 191, 6)), '.', ','));
        arrForm[2]  := AnsiUpperCase(Trim(Copy(strLinha, 197, 10)));
        arrQtd[2]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 207, 6)), '.', ','));
        arrForm[3]  := AnsiUpperCase(Trim(Copy(strLinha, 213, 10)));
        arrQtd[3]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 223, 6)), '.', ','));
        arrForm[4]  := AnsiUpperCase(Trim(Copy(strLinha, 229, 10)));
        arrQtd[4]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 239, 6)), '.', ','));
        arrForm[5]  := AnsiUpperCase(Trim(Copy(strLinha, 245, 10)));
        arrQtd[5]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 255, 6)), '.', ','));
        arrForm[6]  := AnsiUpperCase(Trim(Copy(strLinha, 261, 10)));
        arrQtd[6]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 271, 6)), '.', ','));
        arrForm[7]  := AnsiUpperCase(Trim(Copy(strLinha, 277, 10)));
        arrQtd[7]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 287, 6)), '.', ','));
        arrForm[8]  := AnsiUpperCase(Trim(Copy(strLinha, 293, 10)));
        arrQtd[8]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 303, 6)), '.', ','));
        arrForm[9]  := AnsiUpperCase(Trim(Copy(strLinha, 309, 10)));
        arrQtd[9]   := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 319, 6)), '.', ','));
        arrForm[10] := AnsiUpperCase(Trim(Copy(strLinha, 325, 10)));
        arrQtd[10]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 335, 6)), '.', ','));
        arrForm[11] := AnsiUpperCase(Trim(Copy(strLinha, 341, 10)));
        arrQtd[11]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 351, 6)), '.', ','));
        arrForm[12] := AnsiUpperCase(Trim(Copy(strLinha, 357, 10)));
        arrQtd[12]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 367, 6)), '.', ','));
        arrForm[13] := AnsiUpperCase(Trim(Copy(strLinha, 373, 10)));
        arrQtd[13]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 383, 6)), '.', ','));
        arrForm[14] := AnsiUpperCase(Trim(Copy(strLinha, 389, 10)));
        arrQtd[14]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 399, 6)), '.', ','));
        arrForm[15] := AnsiUpperCase(Trim(Copy(strLinha, 405, 10)));
        arrQtd[15]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 415, 6)), '.', ','));
        arrForm[16] := AnsiUpperCase(Trim(Copy(strLinha, 421, 10)));
        arrQtd[16]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 431, 6)), '.', ','));
        arrForm[17] := AnsiUpperCase(Trim(Copy(strLinha, 437, 10)));
        arrQtd[17]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 447, 6)), '.', ','));
        arrForm[18] := AnsiUpperCase(Trim(Copy(strLinha, 453, 10)));
        arrQtd[18]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 463, 6)), '.', ','));
        arrForm[19] := AnsiUpperCase(Trim(Copy(strLinha, 469, 10)));
        arrQtd[19]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 479, 6)), '.', ','));
        arrForm[20] := AnsiUpperCase(Trim(Copy(strLinha, 485, 10)));
        arrQtd[20]  := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 495, 6)), '.', ','));

        qryCadPpg.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryCadPpg.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);

        qryCadPpg.ParamByName('CODSEQ').AsString := fStrZero(intAtual, 6);
        qryCadPpg.ParamByName('DESCOR').AsString := strDescricao;
        qryCadPpg.ParamByName('VEICUL').AsString := strModelo;
        qryCadPpg.ParamByName('MONTAD').AsString := strMontadora;
        qryCadPpg.ParamByName('TIPO__').AsString := strProduto;

        qryCadPpg.ParamByName('A_N_O_').AsString := strAnoInicial;
        if StrToIntDef(strAnoFinal, 0) > 0 then
          qryCadPpg.ParamByName('A_N_O_').AsString := qryCadPpg.ParamByName('A_N_O_').AsString + '/' + strAnoFinal;

        if (qryCadPpg.ParamByName('A_N_O_').AsString = '0') then
          qryCadPpg.ParamByName('A_N_O_').AsString := '';

        qryCadPpg.ParamByName('CODCOR').AsString := strCodigo;
        qryCadPpg.ParamByName('CODATC').AsString := strCodPpg;

        For intForm := 1 To 20 Do
        Begin
          If fEmptyStr(arrForm[intForm]) Then
            Break;

          qryCadPpg.ParamByName('CODB' + fStrZero(intForm, 2)).AsString := arrForm[intForm];
          qryCadPpg.ParamByName('QTDB' + fStrZero(intForm, 2)).AsFloat := arrQtd[intForm];
        End;

        qryCadPpg.ExecSQL;
      End;
      pRegistraProgresso(0, intAtual, intMax);
      intAtual := intAtual + 1;

    End;
    pRegistraAcao('Cadastro de tintas realizado com sucesso!');
  finally
    CloseFile(arqPpg);
    Result := True;
  end;

end;

function TPpgAutomotivaDinamica.fProximoSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT (IFNULL(MAX(LEFT(AUTOINCREM, 17)), 0) + 1) PROX FROM PPG_CADPPG;';
  qryGen.Open;
  Result := qryGen.FieldByName('PROX').AsInteger;
  FreeAndNil(qryGen);
end;

class function TPpgAutomotivaDinamica.fRetProxCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT (IFNULL(MAX(PPG_CODSEQ), 0) + 1) PROX FROM PPG_CADPPG;';
  qryGen.Open;
  Result := qryGen.FieldByName('PROX').AsInteger;
  FreeAndNil(qryGen);
end;

procedure TPpgAutomotivaDinamica.SetOpcoes(const Value: TPpgOpcoes);
begin
  FOpcoes := Value;
end;

function TPpgAutomotivaDinamica.fProcessaArquivosNovos: Boolean;
begin
  Result := True;

  If TPpgGeraBases in Opcoes Then
    Result := Result And fProcessaCadBasNovo;

  If TPpgGeraTintas in Opcoes Then
    Result := Result And fProcessaCadPpgNovo;
end;

function TPpgAutomotivaDinamica.fProcessaCadBasNovo: Boolean;
var
  stlArquivos: TStringList;
  arquivos   : TSearchRec;
  qryCadBas  : TUniQuery;
  intAtual   : Integer;
  intMax     : Integer;
  strTipo,
  strTipoBas : String;
begin
  try

    stlArquivos := TStringList.Create;

    If (FindFirst(strPat + '\*.txt', faAnyFile, arquivos) = 0) Then
    Begin
      Repeat
        stlArquivos.Add(strPat  + '\' + arquivos.Name);
      Until (FindNext(arquivos) <> 0);

    End;
    FindClose(arquivos);

    If stlArquivos.Count <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum arquivo da PPG Novo. Verifique as configurações ou se o diretório informado encontra-se vazio.', ['&Ok']);
      pDestroiClientDataSetBases;
      FreeAndNil(stlArquivos);
      Result := False;
      Exit;
    End;

    pCriaClientDataSetBases;
    pPreencheClientDataSetBases(stlArquivos);

    //Processando
    qryCadBas := fCriaQuery(Self);
    qryCadBas.Close;
    qryCadBas.SQL.Clear;
    qryCadBas.SQL.Text := 'SELECT * FROM PPG_CADBAS';
    qryCadBas.Open;

    intAtual := qryCadBas.RecordCount + 1;

    pRegistraAcao('Cadastrando bases...');

    If Not cdstblBASIC.IsEmpty Then
    Begin
       intMax   := IIF(intAtual > 1,cdstblBASIC.RecordCount + intAtual,cdstblBASIC.RecordCount);
       cdstblBASIC.First;
       while not cdstblBASIC.Eof do
       begin
         Application.ProcessMessages;

         If Not qryCadBas.Locate('BAS_CODBAS', cdstblBASIC.FieldByName('BASIC_CODE').AsString, []) And
                fBasePodeGravar(cdstblBASIC.FieldByName('BASIC_CODE').AsString) Then
         Begin
           //PEGA DESCRICAO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(cdstblBASIC.FieldByName('BASIC_CODE').AsString) +
                                    'AND SELECTION = ' + QuotedStr('D8');
           cdstblLOOKUP.Filtered := True;

           qryCadBas.Insert;

           qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
           qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);
           qryCadBas.FieldByName('BAS_CODBAS').AsString := cdstblBASIC.FieldByName('BASIC_CODE').AsString;
           qryCadBas.FieldByName('BAS_DESBAS').AsString := cdstblLOOKUP.FieldByName('VALUE').AsString;
           qryCadBas.FieldByName('BAS_PESESP').AsFloat  := cdstblBASIC.FieldByName('DENSIT').AsFloat;

           qryTINTDETAIL.Close;
           qryTINTDETAIL.SQL.Clear;
           qryTINTDETAIL.SQL.Add('SELECT * FROM TMP_TINTDETAIL WHERE BASIC_CODE = :BASIC_CODE LIMIT 1');
           qryTINTDETAIL.ParamByName('BASIC_CODE').AsString := cdstblBASIC.FieldByName('BASIC_CODE').AsString;
           qryTINTDETAIL.Open;

           qryLAYER.Close;
           qryLAYER.SQL.Clear;
           qryLAYER.SQL.Add('SELECT * FROM TMP_LAYER WHERE RECIPE_NUMBER = :RECIPE_NUMBER ');
           qryLAYER.ParamByName('RECIPE_NUMBER').AsString := qryTINTDETAIL.FieldByName('RECIPE_NUMBER').AsString;
           qryLAYER.Open;

           //PEGA TIPO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(qryLAYER.FieldByName('MIXING_SCHEME').AsString) +
                                    ' AND SELECTION = ' + QuotedStr('D4') +
                                    ' AND IDIOMA = ' + QuotedStr('PT');
           cdstblLOOKUP.Filtered := True;

           strTipo := Trim(cdstblLOOKUP.FieldByName('VALUE').AsString);

           if strTipo = 'DELTRON(LA)' then
             strTipo := 'DELTRON'
           else if strTipo = 'ENVIROBASE HP' then
             strTipo := 'ENVIROBASE';

           //PEGA TIPO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(qryLAYER.FieldByName('PRODUCT_OPTION').AsString) +
                                    ' AND SELECTION = ' + QuotedStr('D5') +
                                    ' AND IDIOMA = ' + QuotedStr('PT');
           cdstblLOOKUP.Filtered := True;

           strTipoBas := Trim(cdstblLOOKUP.FieldByName('VALUE').AsString);

           if Pos('DN(LA) BC',strTipoBas ) > 0 then
             strTipoBas := ' BC'
           else if Pos('DN(LA) DG',strTipoBas) > 0 then
             strTipoBas := ' DG'
           else
             strTipoBas := '';

           qryCadBas.FieldByName('BAS_TIPO__').AsString := strTipo + strTipoBas; //cdstblLOOKUP.FieldByName('VALUE').AsString;
           qryCadBas.Post;
         End;

         pRegistraProgresso(0, intAtual, intMax);
         intAtual := intAtual + 1;

         cdstblBASIC.Next;
       end;
    End
    Else If Not cdstblUSEDBASIC.IsEmpty Then //ESSA OPÇÃO É PARA A NEXA QUE NÃO TEM O ARQUIVO BASIC.TXT QUE É O ARQUIVO DAS BASES DA PPG
    Begin
       intMax   := IIF(intAtual > 1,cdstblUSEDBASIC.RecordCount + intAtual - 1,cdstblUSEDBASIC.RecordCount);
       cdstblUSEDBASIC.First;
       while not cdstblUSEDBASIC.Eof do
       begin
         Application.ProcessMessages;

         If Not qryCadBas.Locate('BAS_CODBAS', cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString, []) And
                fBasePodeGravar(cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString) Then
         Begin
           //PEGA DESCRICAO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString) +
                                    'AND SELECTION = ' + QuotedStr('D8');
           cdstblLOOKUP.Filtered := True;

           qryCadBas.Insert;

           qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
           qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);
           qryCadBas.FieldByName('BAS_CODBAS').AsString := cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString;
           qryCadBas.FieldByName('BAS_DESBAS').AsString := cdstblLOOKUP.FieldByName('VALUE').AsString;
           qryCadBas.FieldByName('BAS_PESESP').AsFloat  := cdstblUSEDBASIC.FieldByName('DENSIT').AsFloat;

           qryTINTDETAIL.Close;
           qryTINTDETAIL.SQL.Clear;
           qryTINTDETAIL.SQL.Add('SELECT * FROM TMP_TINTDETAIL WHERE BASIC_CODE = :BASIC_CODE LIMIT 1');
           qryTINTDETAIL.ParamByName('BASIC_CODE').AsString := cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString;
           qryTINTDETAIL.Open;

           qryLAYER.Close;
           qryLAYER.SQL.Clear;
           qryLAYER.SQL.Add('SELECT * FROM TMP_LAYER WHERE RECIPE_NUMBER = :RECIPE_NUMBER ');
           qryLAYER.ParamByName('RECIPE_NUMBER').AsString := qryTINTDETAIL.FieldByName('RECIPE_NUMBER').AsString;
           qryLAYER.Open;

           //PEGA TIPO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(qryLAYER.FieldByName('MIXING_SCHEME').AsString) +
                                    ' AND SELECTION = ' + QuotedStr('D4') +
                                    ' AND IDIOMA = ' + QuotedStr('PT');
           cdstblLOOKUP.Filtered := True;

           strTipo := Trim(cdstblLOOKUP.FieldByName('VALUE').AsString);

           if strTipo = 'DELTRON(LA)' then
             strTipo := 'DELTRON'
           else if strTipo = 'ENVIROBASE HP' then
             strTipo := 'ENVIROBASE';

           //PEGA TIPO DA BASE
           cdstblLOOKUP.Filtered := False;
           cdstblLOOKUP.Filter   := '';
           cdstblLOOKUP.Filter   := 'CODE = ' + QuotedStr(qryLAYER.FieldByName('PRODUCT_OPTION').AsString) +
                                    ' AND SELECTION = ' + QuotedStr('D5') +
                                    ' AND IDIOMA = ' + QuotedStr('PT');
           cdstblLOOKUP.Filtered := True;

           strTipoBas := Trim(cdstblLOOKUP.FieldByName('VALUE').AsString);

           if Pos('DN(LA) BC',strTipoBas ) > 0 then
             strTipoBas := ' BC'
           else if Pos('DN(LA) DG',strTipoBas) > 0 then
             strTipoBas := ' DG'
           else
             strTipoBas := '';

           qryCadBas.FieldByName('BAS_TIPO__').AsString := strTipo + strTipoBas; //cdstblLOOKUP.FieldByName('VALUE').AsString;

           qryCadBas.Post;
         End;

         pRegistraProgresso(0, intAtual, intMax);
         intAtual := intAtual + 1;

         cdstblUSEDBASIC.Next;
       end;
    End;
    
    pRegistraAcao('Cadastro de bases realizado com sucesso!');
  finally
    pDestroiClientDataSetBases;
    FreeAndNil(stlArquivos);
    FreeAndNil(qryCadBas);
    Result := True;
  end;
end;

function TPpgAutomotivaDinamica.fProcessaCadPpgNovo: Boolean;
  Var
    stlArquivos: TStringList;
    arquivos   :  TSearchRec;

    intAtual  : Integer;

    qryCadPpg : TUniQuery;

    arrForm: Array[1..20] of String;
    arrQtd: Array[1..20] of Double;
    intForm: Integer;
    bPodeGravar: Boolean;

    procedure Limpar();
    var
      i: Integer;
    Begin
      qryCadPpg.ParamByName('CODEMP').Value := Null;
      qryCadPpg.ParamByName('AUTOINCREM').Value := Null;

      qryCadPpg.ParamByName('CODSEQ').Value := Null;
      qryCadPpg.ParamByName('DESCOR').Value := Null;
      qryCadPpg.ParamByName('VEICUL').Value := Null;
      qryCadPpg.ParamByName('MONTAD').Value := Null;
      qryCadPpg.ParamByName('TIPO__').Value := Null;
      qryCadPpg.ParamByName('A_N_O_').Value := Null;
      qryCadPpg.ParamByName('CODCOR').Value := Null;
      qryCadPpg.ParamByName('CODATC').Value := Null;
      qryCadPpg.ParamByName('VARIAN').Value := Null;
      qryCadPpg.ParamByName('REFERE').Value := Null;
      For i := 1 To 20 Do
      Begin
        arrForm[i] := '';
        arrQtd[i] := 0.0;
        qryCadPpg.ParamByName('CODB' + fStrZero(i, 2)).Value := Null;
        qryCadPpg.ParamByName('QTDB' + fStrZero(i, 2)).Value := Null;
      End;
    End;

begin
  try

    stlArquivos := TStringList.Create;
    bPodeGravar := True;

    If (FindFirst(strPat + '\*.txt', faAnyFile, arquivos) = 0) Then
    Begin
      Repeat
        stlArquivos.Add(strPat  + '\' + arquivos.Name);
      Until (FindNext(arquivos) <> 0);

    End;
    FindClose(arquivos);

    If stlArquivos.Count <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum arquivo da PPG Novo. Verifique as configurações ou se o diretório informado encontra-se vazio.', ['&Ok']);
      pDestroiClientDataSetFormulas;
      FreeAndNil(stlArquivos);
      Result := False;
      Exit;
    End;

    pCriaClientDataSetFormulas;
    pPreencheClientDataSetFormulas(stlArquivos);

    qryCadPpg := fCriaQuery(Self);

    If (fMensagem('', 'Deseja limpar a tabela de tintas?', ['SIM', 'NÃO'], 2) = 1) Then
    Begin
      qryCadPpg.SQL.Text := 'TRUNCATE TABLE PPG_CADPPG';
      qryCadPpg.ExecSQL;
    End;

    intAtual := fProximoSeq;

    qryCadPpg.SQL.Clear;
    qryCadPpg.SQL.Add('INSERT DELAYED INTO PPG_CADPPG');
    qryCadPpg.SQL.Add('            (PPG_CODSEQ,');
    qryCadPpg.SQL.Add('             PPG_DESCOR,');
    qryCadPpg.SQL.Add('             PPG_VEICUL,');
    qryCadPpg.SQL.Add('             PPG_MONTAD,');
    qryCadPpg.SQL.Add('             PPG_TIPO__,');
    qryCadPpg.SQL.Add('             PPG_A_N_O_,');
    qryCadPpg.SQL.Add('             PPG_CODCOR,');
    qryCadPpg.SQL.Add('             PPG_CODATC,');
    qryCadPpg.SQL.Add('             PPG_PRECUS,');
    qryCadPpg.SQL.Add('             PPG_PREVEN,');
    qryCadPpg.SQL.Add('             PPG_CODEMP,');
    qryCadPpg.SQL.Add('             AUTOINCREM,');
    qryCadPpg.SQL.Add('             PPG_CODB01,');
    qryCadPpg.SQL.Add('             PPG_QTDB01,');
    qryCadPpg.SQL.Add('             PPG_CODB02,');
    qryCadPpg.SQL.Add('             PPG_QTDB02,');
    qryCadPpg.SQL.Add('             PPG_CODB03,');
    qryCadPpg.SQL.Add('             PPG_QTDB03,');
    qryCadPpg.SQL.Add('             PPG_CODB04,');
    qryCadPpg.SQL.Add('             PPG_QTDB04,');
    qryCadPpg.SQL.Add('             PPG_CODB05,');
    qryCadPpg.SQL.Add('             PPG_QTDB05,');
    qryCadPpg.SQL.Add('             PPG_CODB06,');
    qryCadPpg.SQL.Add('             PPG_QTDB06,');
    qryCadPpg.SQL.Add('             PPG_CODB07,');
    qryCadPpg.SQL.Add('             PPG_QTDB07,');
    qryCadPpg.SQL.Add('             PPG_CODB08,');
    qryCadPpg.SQL.Add('             PPG_QTDB08,');
    qryCadPpg.SQL.Add('             PPG_CODB09,');
    qryCadPpg.SQL.Add('             PPG_QTDB09,');
    qryCadPpg.SQL.Add('             PPG_CODB10,');
    qryCadPpg.SQL.Add('             PPG_QTDB10,');
    qryCadPpg.SQL.Add('             PPG_CODB11,');
    qryCadPpg.SQL.Add('             PPG_QTDB11,');
    qryCadPpg.SQL.Add('             PPG_CODB12,');
    qryCadPpg.SQL.Add('             PPG_QTDB12,');
    qryCadPpg.SQL.Add('             PPG_CODB13,');
    qryCadPpg.SQL.Add('             PPG_QTDB13,');
    qryCadPpg.SQL.Add('             PPG_CODB14,');
    qryCadPpg.SQL.Add('             PPG_QTDB14,');
    qryCadPpg.SQL.Add('             PPG_CODB15,');
    qryCadPpg.SQL.Add('             PPG_QTDB15,');
    qryCadPpg.SQL.Add('             PPG_CODB16,');
    qryCadPpg.SQL.Add('             PPG_QTDB16,');
    qryCadPpg.SQL.Add('             PPG_CODB17,');
    qryCadPpg.SQL.Add('             PPG_QTDB17,');
    qryCadPpg.SQL.Add('             PPG_CODB18,');
    qryCadPpg.SQL.Add('             PPG_QTDB18,');
    qryCadPpg.SQL.Add('             PPG_CODB19,');
    qryCadPpg.SQL.Add('             PPG_QTDB19,');
    qryCadPpg.SQL.Add('             PPG_CODB20,');
    qryCadPpg.SQL.Add('             PPG_QTDB20,');

    qryCadPpg.SQL.Add('             PPG_VARIAN,');
    qryCadPpg.SQL.Add('             PPG_REFERE)');
    qryCadPpg.SQL.Add('VALUES (:CODSEQ,');
    qryCadPpg.SQL.Add('        :DESCOR,');
    qryCadPpg.SQL.Add('        :VEICUL,');
    qryCadPpg.SQL.Add('        :MONTAD,');
    qryCadPpg.SQL.Add('        :TIPO__,');
    qryCadPpg.SQL.Add('        :A_N_O_,');
    qryCadPpg.SQL.Add('        :CODCOR,');
    qryCadPpg.SQL.Add('        :CODATC,');
    qryCadPpg.SQL.Add('        :PRECUS,');
    qryCadPpg.SQL.Add('        :PREVEN,');
    qryCadPpg.SQL.Add('        :CODEMP,');
    qryCadPpg.SQL.Add('        :AUTOINCREM,');
    qryCadPpg.SQL.Add('        :CODB01,');
    qryCadPpg.SQL.Add('        :QTDB01,');
    qryCadPpg.SQL.Add('        :CODB02,');
    qryCadPpg.SQL.Add('        :QTDB02,');
    qryCadPpg.SQL.Add('        :CODB03,');
    qryCadPpg.SQL.Add('        :QTDB03,');
    qryCadPpg.SQL.Add('        :CODB04,');
    qryCadPpg.SQL.Add('        :QTDB04,');
    qryCadPpg.SQL.Add('        :CODB05,');
    qryCadPpg.SQL.Add('        :QTDB05,');
    qryCadPpg.SQL.Add('        :CODB06,');
    qryCadPpg.SQL.Add('        :QTDB06,');
    qryCadPpg.SQL.Add('        :CODB07,');
    qryCadPpg.SQL.Add('        :QTDB07,');
    qryCadPpg.SQL.Add('        :CODB08,');
    qryCadPpg.SQL.Add('        :QTDB08,');
    qryCadPpg.SQL.Add('        :CODB09,');
    qryCadPpg.SQL.Add('        :QTDB09,');
    qryCadPpg.SQL.Add('        :CODB10,');
    qryCadPpg.SQL.Add('        :QTDB10,');
    qryCadPpg.SQL.Add('        :CODB11,');
    qryCadPpg.SQL.Add('        :QTDB11,');
    qryCadPpg.SQL.Add('        :CODB12,');
    qryCadPpg.SQL.Add('        :QTDB12,');
    qryCadPpg.SQL.Add('        :CODB13,');
    qryCadPpg.SQL.Add('        :QTDB13,');
    qryCadPpg.SQL.Add('        :CODB14,');
    qryCadPpg.SQL.Add('        :QTDB14,');
    qryCadPpg.SQL.Add('        :CODB15,');
    qryCadPpg.SQL.Add('        :QTDB15,');
    qryCadPpg.SQL.Add('        :CODB16,');
    qryCadPpg.SQL.Add('        :QTDB16,');
    qryCadPpg.SQL.Add('        :CODB17,');
    qryCadPpg.SQL.Add('        :QTDB17,');
    qryCadPpg.SQL.Add('        :CODB18,');
    qryCadPpg.SQL.Add('        :QTDB18,');
    qryCadPpg.SQL.Add('        :CODB19,');
    qryCadPpg.SQL.Add('        :QTDB19,');
    qryCadPpg.SQL.Add('        :CODB20,');
    qryCadPpg.SQL.Add('        :QTDB20,');
    qryCadPpg.SQL.Add('        :VARIAN,');
    qryCadPpg.SQL.Add('        :REFERE);');

    pRegistraAcao('Cadastrando tintas...');
    cdstblCOLOR.First;
    While Not cdstblCOLOR.Eof Do
    Begin
      Try
        Try
          qryVEHICLE.Close;
          qryVEHICLE.SQL.Clear;
          qryVEHICLE.SQL.Add('SELECT * FROM TMP_VEHICLE WHERE COLOUR_DESC_NO = :COLOUR_DESC_NO');
          qryVEHICLE.ParamByName('COLOUR_DESC_NO').AsString := cdstblCOLOR.FieldByName('COLOUR_DESC_NO').AsString;
          qryVEHICLE.Open;

          qryCODE.Close;
          qryCODE.SQL.Clear;
          qryCODE.SQL.Add('SELECT * FROM TMP_CODE WHERE COLOUR_DESC_NO = :COLOUR_DESC_NO');
          qryCODE.ParamByName('COLOUR_DESC_NO').AsString := cdstblCOLOR.FieldByName('COLOUR_DESC_NO').AsString;
          qryCODE.Open;

          qrySOURCE.Close;
          qrySOURCE.SQL.Clear;
          qrySOURCE.SQL.Add('SELECT * FROM TMP_SOURCE WHERE SOURCE_NUMBER = :SOURCE_NUMBER');
          qrySOURCE.ParamByName('SOURCE_NUMBER').AsString := cdstblCOLOR.FieldByName('SOURCE_NUMBER').AsString;
          qrySOURCE.Open;

          qryVARIANT.Close;
          qryVARIANT.SQL.Clear;
          qryVARIANT.SQL.Add('SELECT * FROM TMP_VARIANT WHERE COLOUR_DESC_NO = :COLOUR_DESC_NO');
          qryVARIANT.ParamByName('COLOUR_DESC_NO').AsString := cdstblCOLOR.FieldByName('COLOUR_DESC_NO').AsString;
          qryVARIANT.Open;

          While Not qryVARIANT.Eof Do
          Begin
            Try
              Try
                qryMATCH.Close;
                qryMATCH.SQL.Clear;
                qryMATCH.SQL.Add('SELECT * FROM TMP_MATCH WHERE COLOUR_DESC_NO = :COLOUR_DESC_NO ');
                qryMATCH.SQL.Add('AND PATTERN_NUMBER = :PATTERN_NUMBER AND BASECOAT_INDICATOR = :BASECOAT_INDICATOR ');
                qryMATCH.ParamByName('COLOUR_DESC_NO').AsString      := qryVARIANT.FieldByName('COLOUR_DESC_NO').AsString;
                qryMATCH.ParamByName('PATTERN_NUMBER').AsString      := qryVARIANT.FieldByName('PATTERN_NUMBER').AsString;
                qryMATCH.ParamByName('BASECOAT_INDICATOR').AsInteger := qryVARIANT.FieldByName('BASECOAT_INDICATOR').AsInteger;
                qryMATCH.Open;

                While Not qryMATCH.Eof Do
                Begin
                   Limpar;

                   qryLAYER.Close;
                   qryLAYER.SQL.Clear;
                   qryLAYER.SQL.Add('SELECT * FROM TMP_LAYER WHERE PATTERN_NUMBER = :PATTERN_NUMBER ');
                   qryLAYER.SQL.Add('AND BASECOAT_INDICATOR = :BASECOAT_INDICATOR AND MIXING_SCHEME = :MIXING_SCHEME ');
                   qryLAYER.SQL.Add('AND PRODUCT_OPTION = :PRODUCT_OPTION AND BUSINESS_TERRITORY = :BUSINESS_TERRITORY ');
                   qryLAYER.SQL.Add('AND STATUS = :STATUS AND TIER = :TIER ');
                   qryLAYER.ParamByName('PATTERN_NUMBER').AsString      := qryMATCH.FieldByName('PATTERN_NUMBER').AsString;
                   qryLAYER.ParamByName('BASECOAT_INDICATOR').AsInteger := qryMATCH.FieldByName('BASECOAT_INDICATOR').AsInteger;
                   qryLAYER.ParamByName('MIXING_SCHEME').AsInteger      := qryMATCH.FieldByName('MIXING_SCHEME').AsInteger;
                   qryLAYER.ParamByName('PRODUCT_OPTION').AsInteger     := qryMATCH.FieldByName('PRODUCT_OPTION').AsInteger;
                   qryLAYER.ParamByName('BUSINESS_TERRITORY').AsInteger := qryMATCH.FieldByName('BUSINESS_TERRITORY').AsInteger;
                   qryLAYER.ParamByName('STATUS').AsString              := qryMATCH.FieldByName('STATUS').AsString;
                   qryLAYER.ParamByName('TIER').AsString                := qryMATCH.FieldByName('TIER').AsString;
                   qryLAYER.Open;

                   qryTINTDETAIL.Close;
                   qryTINTDETAIL.SQL.Clear;
                   qryTINTDETAIL.SQL.Add('SELECT * FROM TMP_TINTDETAIL WHERE RECIPE_NUMBER = :RECIPE_NUMBER');
                   qryTINTDETAIL.ParamByName('RECIPE_NUMBER').AsString := qryLAYER.FieldByName('RECIPE_NUMBER').AsString;
                   qryTINTDETAIL.Open;

                   qryTINTDETAIL.First;
                   While Not qryTINTDETAIL.Eof Do
                   Begin
                     if not fBasePodeGravar(qryTINTDETAIL.FieldByName('BASIC_CODE').AsString) then
                     begin
                       bPodeGravar := False;
                       Break;
                     end;

                     arrForm[qryTINTDETAIL.FieldByName('SEQUENCE').AsInteger] := qryTINTDETAIL.FieldByName('BASIC_CODE').AsString;
                     arrQtd[qryTINTDETAIL.FieldByName('SEQUENCE').AsInteger]  := fFormataStringFloat(qryTINTDETAIL.FieldByName('GRAMS_PER10L').AsString,2) * 10 ;//fFormataFloat(fStrToFloat(qryTINTDETAIL.FieldByName('GRAMS_PER10L').AsString),2) * 10;

                     qryTINTDETAIL.Next;
                   End;

                   if bPodeGravar then
                   begin
                     qryCadPpg.ParamByName('CODEMP').AsString     := VS_strCodEmp;
                     qryCadPpg.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intAtual, VS_strCodEmp);

                     qryCadPpg.ParamByName('CODSEQ').AsString := fStrZero(intAtual, 6);
                     qryCadPpg.ParamByName('DESCOR').AsString := cdstblCOLOR.FieldByName('NAME').AsString;
                     qryCadPpg.ParamByName('VEICUL').AsString := fRetornaVeiculo;
                     qryCadPpg.ParamByName('MONTAD').AsString := IIF(qrySOURCE.FieldByName('CODE').AsString = '',LeftStr(qrySOURCE.FieldByName('NAME').AsString,3),qrySOURCE.FieldByName('CODE').AsString); //qrySOURCE.FieldByName('CODE').AsString;
                     qryCadPpg.ParamByName('TIPO__').AsString := qryMATCH.FieldByName('LINE').AsString;

                     qryCadPpg.ParamByName('A_N_O_').AsString := cdstblCOLOR.FieldByName('FIRST_YEAR').AsString;

                     if StrToIntDef(cdstblCOLOR.FieldByName('LAST_YEAR').AsString, 0) > 0 then
                       qryCadPpg.ParamByName('A_N_O_').AsString := cdstblCOLOR.FieldByName('FIRST_YEAR').AsString + '/' + cdstblCOLOR.FieldByName('LAST_YEAR').AsString;

                     if qryCadPpg.ParamByName('A_N_O_').AsString = '0' then
                      qryCadPpg.ParamByName('A_N_O_').AsString := '';
                     

                     qryCadPpg.ParamByName('CODCOR').AsString := qryCODE.FieldByName('CODE_OEM').AsString;
                     qryCadPpg.ParamByName('CODATC').AsString := qryVARIANT.FieldByName('VARIANTE').AsString; //qrySOURCE.FieldByName('CODE').AsString + qryCODE.FieldByName('CODE_OEM').AsString;
                     qryCadPpg.ParamByName('VARIAN').AsString := fGetDescriVariant(qryVARIANT.FieldByName('CODE1').AsString); //qryVARIANT.FieldByName('VARIANTE').AsString;
                     qryCadPpg.ParamByName('REFERE').AsString := fRetornaReferencia(qryLAYER.FieldByName('STATUS').AsString);

                     For intForm := 1 To 20 Do
                     Begin
                       If fEmptyStr(arrForm[intForm]) Then
                         Break;

                       qryCadPpg.ParamByName('CODB' + fStrZero(intForm, 2)).AsString := arrForm[intForm];
                       qryCadPpg.ParamByName('QTDB' + fStrZero(intForm, 2)).AsFloat  := arrQtd[intForm];
                     End;

                     If qryCadPpg.ParamByName('REFERE').AsString = 'NEW' Then
                       qryCadPpg.ExecSQL;
                   end;

                   bPodeGravar := True;
                   intAtual := intAtual + 1;

                   Application.ProcessMessages;

                   qryMATCH.Next;
                End;
              Except
                on E: Exception do
                begin
                  pRegistraAcao(Format('%s: %s', [E.ClassName, E.Message]));
                end;
              End;
            Finally
              qryVARIANT.Next;
            End;
          End;
        Except
          on E: Exception do
          begin
            pRegistraAcao(Format('%s: %s', [E.ClassName, E.Message]));
          end;
        End;
      Finally
        cdstblCOLOR.Next;
        pRegistraProgresso(0, cdstblCOLOR.RecNo, cdstblCOLOR.RecordCount);
      End;
    End;

    pRegistraAcao('Cadastro de tintas realizado com sucesso!');
  finally
    pDestroiClientDataSetFormulas;
    FreeAndNil(stlArquivos);
    FreeAndNil(qryCadPpg);
    Result := True;
  end;
end;

procedure TPpgAutomotivaDinamica.pPreencheClientDataSetBases(stlNomArq: TStringList);
var
  intCont: Integer;
begin
  for intCont := 0 to stlNomArq.Count - 1 do
  begin
    If Pos('tbl202Basic.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblBASIC(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Lookup.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblLOOKUP(stlNomArq.Strings[intCont])
    Else If Pos('tbl202UsedBasics.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblUSEDBASIC(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Layers.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblLAYER(stlNomArq.Strings[intCont])
    Else If Pos('tbl202TintDetail.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblTINTDETAIL(stlNomArq.Strings[intCont]);
  end;
end;

procedure TPpgAutomotivaDinamica.pPreencheClientDataSetFormulas(
  stlNomArq: TStringList);
var
  intCont: Integer;
begin
  for intCont := 0 to stlNomArq.Count - 1 do
  begin
    If (Pos('tbl202Layers.txt',stlNomArq.Strings[intCont]) > 0) And (Not (TPpgGeraBases in Opcoes)) Then
      pPreencheClienttblLAYER(stlNomArq.Strings[intCont])
    Else If (Pos('tbl202TintDetail.txt',stlNomArq.Strings[intCont]) > 0) And (Not (TPpgGeraBases in Opcoes)) Then
      pPreencheClienttblTINTDETAIL(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Basic.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblBASIC(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Lookup.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblLOOKUP(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Color.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblCOLOR(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Code.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblCODE(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Vehicle.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblVEHICLE(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Variant.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblVARIANT(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Match.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblMATCH(stlNomArq.Strings[intCont])
    Else If Pos('tbl202Source.txt',stlNomArq.Strings[intCont]) > 0 Then
      pPreencheClienttblSOUCER(stlNomArq.Strings[intCont]);
  end;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblCOLOR(strNomArq: String);
  Var
    arqCOLOR  : TextFile;
    strLinha : String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqCOLOR, strNomArq);
    Reset(arqCOLOR);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela COLOR...');
    While Not Eof(arqCOLOR) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqCOLOR, strLinha);

      cdstblCOLOR.Append;
      cdstblCOLOR.FieldByName('COLOUR_DESC_NO').AsString := fGetStringPipe(strLinha,1);
      cdstblCOLOR.FieldByName('SOURCE_NUMBER').AsInteger := fGetStringPipe(strLinha,2);
      cdstblCOLOR.FieldByName('FIRST_YEAR').AsString     := fGetStringPipe(strLinha,3);
      cdstblCOLOR.FieldByName('LAST_YEAR').AsString      := fGetStringPipe(strLinha,4);
      cdstblCOLOR.FieldByName('VEHICLE_PART').AsInteger  := fGetStringPipe(strLinha,5);
      cdstblCOLOR.FieldByName('COLOUR_FAMILY').AsInteger := fGetStringPipe(strLinha,6);
      cdstblCOLOR.FieldByName('TERRITURY').AsInteger     := fGetStringPipe(strLinha,7);
      cdstblCOLOR.FieldByName('FINISH_EFFECT').AsInteger := fGetStringPipe(strLinha,8);
      cdstblCOLOR.FieldByName('NAME').AsString           := fGetStringPipe(strLinha,9);
      cdstblCOLOR.FieldByName('ENGLISH_NAME').AsString   := fGetStringPipe(strLinha,10);
      cdstblCOLOR.Post;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;
  Finally
    CloseFile(arqCOLOR);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblCODE(strNomArq: String);
var
  arqCODE  : TextFile;
  strLinha : String;
  intLinha: Integer;
  intLinhas: Integer;

begin

  Try

    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqCODE, strNomArq);
    Reset(arqCODE);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela CODE...');
    While Not Eof(arqCODE) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;
      Readln(arqCODE, strLinha);

      qryCODE.ParamByName('COLOUR_DESC_NO').AsString := fGetStringPipe(strLinha,1);
      qryCODE.ParamByName('CODE_OEM').AsString       := fGetStringPipe(strLinha,2);
      qryCODE.ExecSQL;

      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryCODE.SQL.Clear;
    qryCODE.SQL.Add('ALTER TABLE TMP_CODE ENABLE KEYS');
    qryCODE.ExecSQL;
    qryCODE.Close;

  Finally
    CloseFile(arqCODE);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblVEHICLE(strNomArq: String);
  Var
    arqVEHICLE  : TextFile;
    strLinha  : String;
    intLinha: Integer;
    intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqVEHICLE, strNomArq);
    Reset(arqVEHICLE);
    intLinha := 0;
    
    pRegistraAcao('Preenchendo tabela VEHICLE...');
    While Not Eof(arqVEHICLE) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqVEHICLE, strLinha);

      qryVEHICLE.ParamByName('COLOUR_DESC_NO').AsString := fGetStringPipe(strLinha,1);
      qryVEHICLE.ParamByName('DESCRIPTION').AsString    := fGetStringPipe(strLinha,2);
      qryVEHICLE.ExecSQL;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryVEHICLE.SQL.Clear;
    qryVEHICLE.SQL.Add('ALTER TABLE TMP_VEHICLE ENABLE KEYS');
    qryVEHICLE.ExecSQL;
    qryVEHICLE.Close;
  Finally
    CloseFile(arqVEHICLE);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblVARIANT(strNomArq: String);
var
  arqVARIANT  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqVARIANT, strNomArq);
    Reset(arqVARIANT);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela VARIANT...');
    While Not Eof(arqVARIANT) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqVARIANT, strLinha);

      qryVARIANT.ParamByName('COLOUR_DESC_NO').AsString      := fGetStringPipe(strLinha,1);
      qryVARIANT.ParamByName('PATTERN_NUMBER').AsString      := fGetStringPipe(strLinha,2);
      qryVARIANT.ParamByName('BASECOAT_INDICATOR').AsInteger := fGetStringPipe(strLinha,3);
      qryVARIANT.ParamByName('CODE1').AsString               := fGetStringPipe(strLinha,4);      
      qryVARIANT.ParamByName('VARIANTE').AsString            := fGetStringPipe(strLinha,7);      
      qryVARIANT.ExecSQL;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryVARIANT.SQL.Clear;
    qryVARIANT.SQL.Add('ALTER TABLE TMP_VARIANT ENABLE KEYS');
    qryVARIANT.ExecSQL;
    qryVARIANT.Close;
  Finally
    CloseFile(arqVARIANT);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblMATCH(strNomArq: String);
var
  arqMATCH  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;

begin

  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqMATCH, strNomArq);
    Reset(arqMATCH);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela MATCH...');
    While Not Eof(arqMATCH) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;
      Readln(arqMATCH, strLinha);

        qryMATCH.ParamByName('COLOUR_DESC_NO').AsString      := fGetStringPipe(strLinha,1);
        qryMATCH.ParamByName('PATTERN_NUMBER').AsString      := fGetStringPipe(strLinha,2);
        qryMATCH.ParamByName('BASECOAT_INDICATOR').AsInteger := fGetStringPipe(strLinha,3);
        qryMATCH.ParamByName('MIXING_SCHEME').AsInteger      := fGetStringPipe(strLinha,4);
        qryMATCH.ParamByName('PRODUCT_OPTION').AsInteger     := fGetStringPipe(strLinha,5);
        qryMATCH.ParamByName('BUSINESS_TERRITORY').AsInteger := fGetStringPipe(strLinha,6);
        qryMATCH.ParamByName('STATUS').AsString              := fGetStringPipe(strLinha,7);
        qryMATCH.ParamByName('TIER').AsString                := fGetStringPipe(strLinha,8);
        qryMATCH.ParamByName('COLOUR_REF').AsInteger         := fGetStringPipe(strLinha,9);
        qryMATCH.ParamByName('DATE').AsString                := fGetStringPipe(strLinha,10);
        qryMATCH.ParamByName('LINE').AsString                := fGetStringPipe(strLinha,11);
        qryMATCH.ExecSQL;


      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryMATCH.SQL.Clear;
    qryMATCH.SQL.Add('ALTER TABLE TMP_MATCH ENABLE KEYS');
    qryMATCH.ExecSQL;
    qryMATCH.Close;

  Finally
    CloseFile(arqMATCH);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblLAYER(strNomArq: String);
var
  arqLAYER  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;

begin

  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqLAYER, strNomArq);
    Reset(arqLAYER);
    intLinha := 0;


    pRegistraAcao('Preenchendo tabela LAYER...');
    While Not Eof(arqLAYER) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;
      Readln(arqLAYER, strLinha);

      qryLAYER.ParamByName('PATTERN_NUMBER').AsString      := fGetStringPipe(strLinha,2);
      qryLAYER.ParamByName('BASECOAT_INDICATOR').AsInteger := fGetStringPipe(strLinha,3);
      qryLAYER.ParamByName('MIXING_SCHEME').AsInteger      := fGetStringPipe(strLinha,4);
      qryLAYER.ParamByName('PRODUCT_OPTION').AsInteger     := fGetStringPipe(strLinha,5);
      qryLAYER.ParamByName('BUSINESS_TERRITORY').AsInteger := fGetStringPipe(strLinha,6);
      qryLAYER.ParamByName('STATUS').AsString              := fGetStringPipe(strLinha,7);
      qryLAYER.ParamByName('TIER').AsString                := fGetStringPipe(strLinha,8);
      qryLAYER.ParamByName('LAYER_NUMBER').AsInteger       := fGetStringPipe(strLinha,9);
      qryLAYER.ParamByName('LAYER_CODE').AsInteger         := fGetStringPipe(strLinha,10);
      qryLAYER.ParamByName('LAYER_REF').AsInteger          := fGetStringPipe(strLinha,11);
      qryLAYER.ParamByName('RECIPE_NUMBER').AsString       := fGetStringPipe(strLinha,13);
        qryLAYER.ExecSQL;



      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryLAYER.SQL.Clear;
    qryLAYER.SQL.Add('ALTER TABLE TMP_LAYER ENABLE KEYS');
    qryLAYER.ExecSQL;
    qryLAYER.Close;

  Finally
    CloseFile(arqLAYER);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblTINTDETAIL(strNomArq: String);
Var
  arqTINTDETAIL  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqTINTDETAIL, strNomArq);
    Reset(arqTINTDETAIL);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela TINTDETAIL...');
    While Not Eof(arqTINTDETAIL) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqTINTDETAIL, strLinha);

      qryTINTDETAIL.ParamByName('RECIPE_NUMBER').AsString := fGetStringPipe(strLinha,1);
      qryTINTDETAIL.ParamByName('SEQUENCE').AsInteger     := fGetStringPipe(strLinha,2);
      qryTINTDETAIL.ParamByName('BASIC_CODE').AsString    := fGetStringPipe(strLinha,3);
      qryTINTDETAIL.ParamByName('GRAMS_PER10L').AsString  := fGetStringPipe(strLinha,4);
      qryTINTDETAIL.ExecSQL;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qryTINTDETAIL.SQL.Clear;
    qryTINTDETAIL.SQL.Add('ALTER TABLE TMP_TINTDETAIL ENABLE KEYS');
    qryTINTDETAIL.ExecSQL;
    qryTINTDETAIL.Close;

  Finally
    CloseFile(arqTINTDETAIL);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblBASIC(strNomArq: String);
var
  arqBASIC  : TextFile;
  strLinha  : String;
  intLinhas: Integer;
  intLinha: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqBASIC, strNomArq);
    Reset(arqBASIC);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela BASIC...');
    While Not Eof(arqBASIC) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqBASIC, strLinha);

      cdstblBASIC.Append;
      cdstblBASIC.FieldByName('BASIC_CODE').AsString := fGetStringPipe(strLinha,1);
      cdstblBASIC.FieldByName('DENSIT').AsFloat      := fStrToFloat(AnsiReplaceStr(fGetStringPipe(strLinha,2),'.',','));
      cdstblBASIC.Post;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;
  Finally
    CloseFile(arqBASIC);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblUSEDBASIC(strNomArq: String);
Var
  arqUSEDBASIC  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqUSEDBASIC, strNomArq);
    Reset(arqUSEDBASIC);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela USEDBASIC...');
    While Not Eof(arqUSEDBASIC) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqUSEDBASIC, strLinha);

      cdstblUSEDBASIC.Append;
      cdstblUSEDBASIC.FieldByName('BASIC_CODE').AsString := fGetStringPipe(strLinha,1);
      cdstblUSEDBASIC.FieldByName('DENSIT').AsFloat      := fStrToFloat(AnsiReplaceStr(fGetStringPipe(strLinha,2),'.',','));
      cdstblUSEDBASIC.Post;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;
  Finally
    CloseFile(arqUSEDBASIC);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblLOOKUP(strNomArq: String);
Var
  arqLOOKUP  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqLOOKUP, strNomArq);
    Reset(arqLOOKUP);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela LOOKUP...');
    While Not Eof(arqLOOKUP) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqLOOKUP, strLinha);

      cdstblLOOKUP.Append;
      cdstblLOOKUP.FieldByName('SELECTION').AsString := fGetStringPipe(strLinha,1);
      cdstblLOOKUP.FieldByName('LANGUAGE').AsString  := fGetStringPipe(strLinha,2);
      cdstblLOOKUP.FieldByName('CODE').AsString      := fGetStringPipe(strLinha,3);
      cdstblLOOKUP.FieldByName('VALUE').AsString     := fGetStringPipe(strLinha,4);
      cdstblLOOKUP.FieldByName('IDIOMA').AsString    := fGetStringPipe(strLinha,5);
      cdstblLOOKUP.Post;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;
  Finally
    CloseFile(arqLOOKUP);
  End;
end;

procedure TPpgAutomotivaDinamica.pPreencheClienttblSOUCER(strNomArq: String);
Var
  arqSOURCE  : TextFile;
  strLinha  : String;
  intLinha: Integer;
  intLinhas: Integer;
begin
  Try
    intLinhas := fContaLinhas(strNomArq);
    AssignFile(arqSOURCE, strNomArq);
    Reset(arqSOURCE);
    intLinha := 0;

    pRegistraAcao('Preenchendo tabela SOURCE...');
    While Not Eof(arqSOURCE) Do
    Begin
      Inc(intLinha);
      Application.ProcessMessages;

      Readln(arqSOURCE, strLinha);

      qrySOURCE.ParamByName('SOURCE_NUMBER').AsString := fGetStringPipe(strLinha,1);
      qrySOURCE.ParamByName('TYPE').AsInteger         := fGetStringPipe(strLinha,2);
      qrySOURCE.ParamByName('NAME').AsString          := fGetStringPipe(strLinha,3);
      qrySOURCE.ParamByName('CODE').AsString          := fGetStringPipe(strLinha,4);
      qrySOURCE.ExecSQL;
      pRegistraProgresso(0, intLinha, intLinhas);
    End;

    qrySOURCE.SQL.Clear;
    qrySOURCE.SQL.Add('ALTER TABLE TMP_SOURCE ENABLE KEYS');
    qrySOURCE.ExecSQL;
    qrySOURCE.Close;

  Finally
    CloseFile(arqSOURCE);
  End;
end;

procedure TPpgAutomotivaDinamica.pCriaClientDataSetBases;
begin
  pCriaClienttblBASIC;
  pCriaClienttblLOOKUP;
  pCriaClienttblUSEDBASIC;
  pCriaClienttblLAYER;
  pCriaClienttblTINTDETAIL;
end;

procedure TPpgAutomotivaDinamica.pCriaClientDataSetFormulas;
begin
  pCriaClienttblCOLOR;
  pCriaClienttblCODE;
  pCriaClienttblVEHICLE;
  pCriaClienttblPART;
  pCriaClienttblVARIANT;
  pCriaClienttblMATCH;
  if (Not (TPpgGeraBases in Opcoes)) Then
  begin
    pCriaClienttblLAYER;
    pCriaClienttblTINTDETAIL;
  end;
  pCriaClienttblBASIC;
  pCriaClienttblLOOKUP;
  pCriaClienttblSOURCE;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblCOLOR;
var
  intCont: Integer;
const
  arrCampos: Array[1..10] of String = ('COLOUR_DESC_NO','SOURCE_NUMBER','FIRST_YEAR',
  'LAST_YEAR','VEHICLE_PART','COLOUR_FAMILY','TERRITURY','FINISH_EFFECT','NAME',
  'ENGLISH_NAME');
  arrTipos : Array[1..10] of TFieldType = (ftstring,ftInteger,ftString,ftString,
  ftInteger,ftInteger,ftInteger,ftInteger,ftString,ftString);
  arrSize  : Array[1..10] of Integer  = (12,0,4,4,0,0,0,0,100,100);

begin
  cdstblCOLOR := TUniClientDataSet.Create(Self);
  for intCont := 1 to Length(arrCampos) do
  begin
    with cdstblCOLOR.FieldDefs.AddFieldDef do
    begin
      Name     := arrCampos[intcont];
      DataType := arrTipos[intcont];
      if arrSize[intcont] > 0 then
        Size   := arrSize[intcont];
    end;
  end;
  cdstblCOLOR.CreateDataSet;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblCODE;
{
var
  intCont: Integer;
const
  arrCampos: Array[1..2] of String = ('COLOUR_DESC_NO','CODE_OEM');
  arrTipos : Array[1..2] of TFieldType = (ftstring,ftstring);
  arrSize  : Array[1..2] of Integer  = (12,50);
}
begin
  pDestroiClienttblCODE;

  qryCODE := fCriaQuery(Self);
  With qryCODE Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_CODE (        ');
    SQL.Add('  COLOUR_DESC_NO VARCHAR(12),  ');
    SQL.Add('  CODE_OEM       VARCHAR(100)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_CODE ON TMP_CODE(COLOUR_DESC_NO) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_CODE DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_CODE VALUES ');
    SQL.Add('(:COLOUR_DESC_NO, :CODE_OEM) ');
  End;

end;

procedure TPpgAutomotivaDinamica.pCriaClienttblVEHICLE;
{
var
  intCont: Integer;
const
  arrCampos: Array[1..2] of String = ('COLOUR_DESC_NO','DESCRIPTION');
  arrTipos : Array[1..2] of TFieldType = (ftstring,ftstring);
  arrSize  : Array[1..2] of Integer  = (12,100);
}
begin
  pDestroiClienttblVEHICLE;

  qryVEHICLE:= fCriaQuery(Self);
  With qryVEHICLE Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_VEHICLE (      ');
    SQL.Add('  COLOUR_DESC_NO  VARCHAR(12),  ');
    SQL.Add('  DESCRIPTION     VARCHAR(100)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_VEHICLE ON TMP_VEHICLE(COLOUR_DESC_NO) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_VEHICLE DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_VEHICLE VALUES ');
    SQL.Add('(:COLOUR_DESC_NO, :DESCRIPTION) ');
  End;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblPART;
var
  intCont: Integer;
const
  arrCampos: Array[1..7] of String = ('COLOUR_DESC_NO','LINKED_COLOUR_DESC_NO',
  'MODEL','FIRST_YEAR','LAST_YEAR','FIRST_YEAR_MODEL','LAST_YEAR_MODEL');
  arrTipos : Array[1..7] of TFieldType = (ftstring,ftstring,ftstring,ftstring,
  ftstring,ftstring,ftstring);
  arrSize  : Array[1..7] of Integer  = (12,12,100,4,4,4,4);

begin
  cdstblPART := TUniClientDataSet.Create(Self);
  for intCont := 1 to Length(arrCampos) do
  begin
    with cdstblPART.FieldDefs.AddFieldDef do
    begin
      Name     := arrCampos[intcont];
      DataType := arrTipos[intcont];
      if arrSize[intcont] > 0 then
        Size   := arrSize[intcont];
    end;
  end;
  cdstblPART.CreateDataSet;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblVARIANT;
begin
  pDestroiClienttblVARIANT;

  qryVARIANT := fCriaQuery(Self);
  With qryVARIANT Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_VARIANT (          ');
    SQL.Add('  COLOUR_DESC_NO      VARCHAR(12),  ');
    SQL.Add('  PATTERN_NUMBER      VARCHAR(12),  ');
    SQL.Add('  BASECOAT_INDICATOR  INTEGER,      ');
    SQL.Add('  CODE1               VARCHAR(20),  ');    
    SQL.Add('  VARIANTE            VARCHAR(20)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_VARIANT ON TMP_VARIANT(COLOUR_DESC_NO) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_VARIANT DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_VARIANT VALUES ');
    SQL.Add('(:COLOUR_DESC_NO, :PATTERN_NUMBER, :BASECOAT_INDICATOR, :CODE1, :VARIANTE) ');
  End;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblMATCH;
{
var
  intCont: Integer;
const
  arrCampos: Array[1..11] of String = ('COLOUR_DESC_NO','PATTERN_NUMBER','BASECOAT_INDICATOR',
  'MIXING_SCHEME','PRODUCT_OPTION','BUSINESS_TERRITORY','STATUS','TIER',
  'COLOUR_REF','DATE','LINE');
  arrTipos : Array[1..11] of TFieldType = (ftstring,ftstring,ftInteger,ftInteger,ftInteger,
  ftInteger,ftString,ftString,ftInteger,ftString,ftString);
  arrSize  : Array[1..11] of Integer  = (12,12,0,0,0,0,1,50,0,10,10);
}
begin
  pDestroiClienttblMATCH;

  qryMATCH := fCriaQuery(Self);
  With qryMATCH Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_MATCH (          ');
    SQL.Add('  COLOUR_DESC_NO     VARCHAR(12), ');
    SQL.Add('  PATTERN_NUMBER     VARCHAR(12), ');
    SQL.Add('  BASECOAT_INDICATOR INTEGER,     ');
    SQL.Add('  MIXING_SCHEME      INTEGER,     ');
    SQL.Add('  PRODUCT_OPTION     INTEGER,     ');
    SQL.Add('  BUSINESS_TERRITORY INTEGER,     ');
    SQL.Add('  STATUS             CHAR(1),     ');
    SQL.Add('  TIER               VARCHAR(50), ');
    SQL.Add('  COLOUR_REF         INTEGER,     ');
    SQL.Add('  DATE               VARCHAR(10), ');
    SQL.Add('  LINE               VARCHAR(10)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_MATCH ON TMP_MATCH(COLOUR_DESC_NO,PATTERN_NUMBER,BASECOAT_INDICATOR) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_MATCH DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_MATCH VALUES ');
    SQL.Add('(:COLOUR_DESC_NO, :PATTERN_NUMBER, :BASECOAT_INDICATOR, :MIXING_SCHEME, :PRODUCT_OPTION, :BUSINESS_TERRITORY, :STATUS, :TIER, :COLOUR_REF, :DATE, :LINE) ');
  End;

end;

procedure TPpgAutomotivaDinamica.pCriaClienttblLAYER;
{
const
  arrCampos: Array[1..11] of String = ('PATTERN_NUMBER','BASECOAT_INDICATOR',
  'MIXING_SCHEME','PRODUCT_OPTION','BUSINESS_TERRITORY','STATUS','TIER',
  'LAYER_NUMBER','LAYER_CODE','LAYER_REF','RECIPE_NUMBER');
  arrTipos : Array[1..11] of TFieldType = (ftstring,ftInteger,ftInteger,ftInteger,
  ftInteger,ftstring,ftstring,ftInteger,ftInteger,ftInteger,ftstring);
  arrSize  : Array[1..11] of Integer  = (12,0,0,0,0,1,50,0,0,0,50);

var
  intCont: Integer;
}
begin

  pDestroiClienttblLAYER;

  qryLAYER := fCriaQuery(Self);
  With qryLAYER Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_LAYER (          ');
    SQL.Add('  PATTERN_NUMBER     VARCHAR(12), ');
    SQL.Add('  BASECOAT_INDICATOR INTEGER,     ');
    SQL.Add('  MIXING_SCHEME      INTEGER,     ');
    SQL.Add('  PRODUCT_OPTION     INTEGER,     ');
    SQL.Add('  BUSINESS_TERRITORY INTEGER,     ');
    SQL.Add('  STATUS             CHAR(1),     ');
    SQL.Add('  TIER               VARCHAR(50), ');
    SQL.Add('  LAYER_NUMBER       INTEGER,     ');
    SQL.Add('  LAYER_CODE         INTEGER,     ');
    SQL.Add('  LAYER_REF          INTEGER,     ');
    SQL.Add('  RECIPE_NUMBER      VARCHAR(50)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_LAYER ON TMP_LAYER(PATTERN_NUMBER,BASECOAT_INDICATOR,MIXING_SCHEME,PRODUCT_OPTION,BUSINESS_TERRITORY,STATUS,TIER) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_LAYER DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_LAYER VALUES ');
    SQL.Add('(:PATTERN_NUMBER, :BASECOAT_INDICATOR, :MIXING_SCHEME, :PRODUCT_OPTION, :BUSINESS_TERRITORY, :STATUS, :TIER, :LAYER_NUMBER, :LAYER_CODE, :LAYER_REF, :RECIPE_NUMBER) ');
  End;

end;

procedure TPpgAutomotivaDinamica.pCriaClienttblTINTDETAIL;
begin
  pDestroiClienttblTINTDETAIL;

  qryTINTDETAIL := fCriaQuery(Self);
  With qryTINTDETAIL Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_TINTDETAIL ( ');
    SQL.Add('  RECIPE_NUMBER VARCHAR(50),  ');
    SQL.Add('  SEQUENCE      INTEGER,      ');
    SQL.Add('  BASIC_CODE    VARCHAR(20),  ');
    SQL.Add('  GRAMS_PER10L  VARCHAR(20)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_TINTDETAIL ON TMP_TINTDETAIL(RECIPE_NUMBER) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_TINTDETAIL DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_TINTDETAIL VALUES ');
    SQL.Add('(:RECIPE_NUMBER, :SEQUENCE, :BASIC_CODE, :GRAMS_PER10L) ');
  End;

end;

procedure TPpgAutomotivaDinamica.pCriaClienttblBASIC;
var
  intCont: Integer;
const
  arrCampos: Array[1..2] of String = ('BASIC_CODE','DENSIT');
  arrTipos : Array[1..2] of TFieldType = (ftstring,ftfloat);
  arrSize  : Array[1..2] of Integer  = (20,0);

begin
  cdstblBASIC := TUniClientDataSet.Create(Self);
  for intCont := 1 to Length(arrCampos) do
  begin
    with cdstblBASIC.FieldDefs.AddFieldDef do
    begin
      Name     := arrCampos[intcont];
      DataType := arrTipos[intcont];
      if arrSize[intcont] > 0 then
        Size   := arrSize[intcont];
    end;
  end;
  cdstblBASIC.CreateDataSet;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblUSEDBASIC;
var
  intCont: Integer;
const
  arrCampos: Array[1..2] of String = ('BASIC_CODE','DENSIT');
  arrTipos : Array[1..2] of TFieldType = (ftstring,ftfloat);
  arrSize  : Array[1..2] of Integer  = (20,0);

begin
  cdstblUSEDBASIC := TUniClientDataSet.Create(Self);
  for intCont := 1 to Length(arrCampos) do
  begin
    with cdstblUSEDBASIC.FieldDefs.AddFieldDef do
    begin
      Name     := arrCampos[intcont];
      DataType := arrTipos[intcont];
      if arrSize[intcont] > 0 then
        Size   := arrSize[intcont];
    end;
  end;
  cdstblUSEDBASIC.CreateDataSet;
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblSOURCE;
const
  arrCampos: Array[1..4] of String = ('SOURCE_NUMBER','TYPE','NAME','CODE');
  arrTipos : Array[1..4] of TFieldType = (ftstring,ftInteger,ftstring,ftstring);
  arrSize  : Array[1..4] of Integer  = (12,0,100,20);

begin
  pDestroiClienttblSOURCE;

  qrySOURCE := fCriaQuery(Self);
  With qrySOURCE Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_SOURCE (      ');
    SQL.Add('  SOURCE_NUMBER VARCHAR(12),   ');
    SQL.Add('  TYPE          INTEGER,       ');
    SQL.Add('  NAME          VARCHAR(100),  ');
    SQL.Add('  CODE          VARCHAR(20)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_SOURCE ON TMP_SOURCE(SOURCE_NUMBER) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_SOURCE DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_SOURCE VALUES ');
    SQL.Add('(:SOURCE_NUMBER, :TYPE, :NAME, :CODE) ');
  End;

end;

procedure TPpgAutomotivaDinamica.pDestroiClientDataSetBases;
begin
  pDestroiClienttblBASIC;
  pDestroiClienttblLOOKUP;
  pDestroiClienttblUSEDBASIC;
  if (Not (TPpgGeraTintas in Opcoes)) Then
  begin
    pDestroiClienttblLAYER;
    pDestroiClienttblTINTDETAIL;
  end;
end;

procedure TPpgAutomotivaDinamica.pDestroiClientDataSetFormulas;
begin
  pDestroiClienttblCOLOR;
  pDestroiClienttblCODE;
  pDestroiClienttblVEHICLE;
  pDestroiClienttblPART;
  pDestroiClienttblVARIANT;
  pDestroiClienttblMATCH;
  pDestroiClienttblLAYER;
  pDestroiClienttblTINTDETAIL;
  pDestroiClienttblBASIC;
  pDestroiClienttblLOOKUP;
  pDestroiClienttblSOURCE;  
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblCOLOR;
begin
  FreeAndNil(cdstblCOLOR);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblCODE;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_CODE');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryCODE) then
    FreeAndNil(qryCODE);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblVEHICLE;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_VEHICLE');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryVEHICLE) then
    FreeAndNil(qryVEHICLE);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblPART;
begin
  FreeAndNil(cdstblPART);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblVARIANT;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_VARIANT');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryVARIANT) then
    FreeAndNil(qryVARIANT);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblMATCH;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_MATCH');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryMATCH) then
    FreeAndNil(qryMATCH);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblLAYER;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_LAYER');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryLAYER) then
    FreeAndNil(qryLAYER);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblTINTDETAIL;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_TINTDETAIL');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qryTINTDETAIL) then
    FreeAndNil(qryTINTDETAIL);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblBASIC;
begin
  FreeAndNil(cdstblBASIC);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblUSEDBASIC;
begin
  FreeAndNil(cdstblUSEDBASIC);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblLOOKUP;
begin
  FreeAndNil(cdstblLOOKUP);
end;

procedure TPpgAutomotivaDinamica.pDestroiClienttblSOURCE;
  Var
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery(Self);
    Try
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_SOURCE');
      qryTmp.ExecSQL;
    Except

    End;
  Finally
    FreeAndNil(qryTmp);
  End;

  if Assigned(qrySOURCE) then
    FreeAndNil(qrySOURCE);
end;

procedure TPpgAutomotivaDinamica.pCriaClienttblLOOKUP;
var
  intCont: Integer;
const  
  arrCampos: Array[1..5] of String = ('SELECTION','LANGUAGE','CODE','VALUE',
  'IDIOMA');
  arrTipos : Array[1..5] of TFieldType = (ftstring,ftstring,ftstring,ftstring,
  ftstring);
  arrSize  : Array[1..5] of Integer  = (02,02,10,100,02);

begin
  cdstblLOOKUP := TUniClientDataSet.Create(Self);
  for intCont := 1 to Length(arrCampos)  do
  begin
    with cdstblLOOKUP.FieldDefs.AddFieldDef do
    begin
      Name     := arrCampos[intcont];
      DataType := arrTipos[intcont];
      if arrSize[intcont] > 0 then
        Size   := arrSize[intcont];
    end;
  end;
  cdstblLOOKUP.CreateDataSet;
end;

//bases que nao podem ser geradas
function TPpgAutomotivaDinamica.fBasePodeGravar(strCodBas: String): Boolean;
const arrBases: array[1..14] of string = ('AA-01','AA-02','AA-03','BA-04','BA-05','BP-04','BP-05','DUL600','DUL601','DUL602','DUL603','DUL604','DUL605','DUL723');
var
  intCont: Integer;
begin
  Result := True;
  for intCont := 1 to Length(arrBases) do
  begin
    if arrBases[intCont] = strCodBas then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

function TPpgAutomotivaDinamica.fFormataStringFloat(strValor: String; intDecimal: Integer): Double;
var
  strString: String;
begin
  strString := Copy(strValor,1,Length(strValor) - intDecimal) + ',' + Copy(strValor,Length(strValor) - 1,intDecimal);

  Result := fStrToFloat(strString);
end;

function TPpgAutomotivaDinamica.fRetornaVeiculo: String;
begin
  Result := '';
  qryVEHICLE.First;
  While Not qryVEHICLE.Eof Do
  Begin

    If Result = '' Then
      Result := qryVEHICLE.FieldByName('DESCRIPTION').AsString
    Else
      Result := Result + ',' + qryVEHICLE.FieldByName('DESCRIPTION').AsString;

    qryVEHICLE.Next;
  End;
end;

function TPpgAutomotivaDinamica.fGetDescriVariant(strVariant: string): string;
begin
  strVariant := Trim(UpperCase(strVariant));
  Result := strVariant;

  if MatchText(strVariant, ['PRIME']) then
    Exit;  

  strVariant := StringReplace(strVariant, 'DI', ' +sujo ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, '//', ' angulo (flop) ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'VI', ' +vivo ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'B', ' +azul ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'D', ' +escuro ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'O', ' +laranja ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'V', ' +violeta ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'Y', ' +amarelo ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'G', ' +verde ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'C', ' aluminio + grosso ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'F', ' alumini + fino ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'R', ' +vermelho ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'W', ' +branco ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, 'L', ' +claro ', [rfReplaceAll]);
  strVariant := StringReplace(strVariant, '  ', ' ', [rfReplaceAll]);
  Result := Trim(UpperCase(strVariant));
end;

function TPpgAutomotivaDinamica.fGetStringPipe(strLinha: String; intPosicao: Integer): Variant;
var
  strQuebra: String;
  intCont: Integer;
begin
  Result    := '';
  intCont   := 0;
  strQuebra := strLinha;
  repeat
    if Pos('|',strQuebra) > 0 then
      Result := Copy(strQuebra,1,Pos('|',strQuebra) - 1)
    else
      Result := strQuebra;

    strQuebra := Copy(strQuebra,Pos('|',strQuebra) + 1,Length(strQuebra));
    inc(intCont);
  until intPosicao = intCont;
end;

function TPpgAutomotivaDinamica.fRetornaReferencia(strStatus: String): String;
begin
  if strStatus = 'O' then
    Result := 'OLD'
  else if strStatus = 'N' then
    Result := 'NEW'
  else
    Result := '';  
end;

end.

