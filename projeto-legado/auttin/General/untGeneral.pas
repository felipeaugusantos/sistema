unit untGeneral;

interface

uses untTintadeMaquina, ADODB, Uni,  Classes;

Type
  TGeneral = class(TTintadeMaquina)
  private
    FstrPath: String;
    function fProcessarCadBas: Boolean;
    function fProcessarCadGen: Boolean;
    function fProcessarCadMon: Boolean;
    procedure SetstrPath(const Value: String);
    function fGetNomeProduto(strCodProd: String): String;
  public
    constructor Create(AOwner: TComponent); override;

    function fProcessarArquivos: Boolean;

    function fGravarNovasFormulas: Boolean; override;
    property strPath: String read FstrPath write SetstrPath;
    class function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  End;

implementation

uses untFuncoesSimples, DB, SysUtils, Variants, StrUtils, Math;



{ TGeneral }

constructor TGeneral.Create(AOwner: TComponent);
begin
  inherited;
  NomeTinta := 'General';
  FstrPath := 'C:\Arquivos de programas\SysteMachine\MDB\GENERAL.mdb';//fArqIniTinta(0, 'GENERAL', 'PATGEN', '');
end;

function TGeneral.fGetNomeProduto(strCodProd: String): String;
begin
  strCodProd := LeftStr(strCodProd, 3);
  Result := '';

  If strCodProd = '711' Then
    Result := 'ESMALTE SINTETICO'
  Else If strCodProd = '721' Then
    Result := 'LACA NICTROCELULOSE'
  Else If strCodProd = '741' Then
    Result := 'BASE POLIESTER'
  Else If strCodProd = '751' Then
    Result := 'PU';
end;

class function TGeneral.fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'DELETE FROM GEN_CADGEN WHERE GEN_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO GEN_CADGEN ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              GEN_CODIGO, ');
  qryGen.SQL.Add('              GEN_VARIAC, ');
  qryGen.SQL.Add('              GEN_DESCRI, ');
  qryGen.SQL.Add('              GEN_CODMON, ');
  qryGen.SQL.Add('              GEN_ANOINI, ');
  qryGen.SQL.Add('              GEN_ANOFIN, ');
  qryGen.SQL.Add('              GEN_NACION, ');
  qryGen.SQL.Add('              GEN_CODCOR, ');
  qryGen.SQL.Add('              GEN_VERSAO, ');
  qryGen.SQL.Add('              GEN_OBSERV, ');
  qryGen.SQL.Add('              GEN_CODNFM, ');

  For intCont := 1 To 15 Do
  Begin
    qryGen.SQL.Add('              GEN_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              GEN_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              GEN_PRODUT) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :GEN_CODIGO, ');
  qryGen.SQL.Add('         :GEN_VARIAC, ');
  qryGen.SQL.Add('         :GEN_DESCRI, ');
  qryGen.SQL.Add('         :GEN_CODMON, ');
  qryGen.SQL.Add('         :GEN_ANOINI, ');
  qryGen.SQL.Add('         :GEN_ANOFIN, ');
  qryGen.SQL.Add('         :GEN_NACION, ');
  qryGen.SQL.Add('         :GEN_CODCOR, ');
  qryGen.SQL.Add('         :GEN_VERSAO, ');
  qryGen.SQL.Add('         :GEN_OBSERV, ');
  qryGen.SQL.Add('         :GEN_CODNFM, ');

  For intCont := 1 To 15 Do
  Begin
    qryGen.SQL.Add('         :GEN_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('         :GEN_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('         :GEN_PRODUT); ');

  qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GEN_CADGEN', VS_strCodEmp);
  qryGen.ParamByName('GEN_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  qryGen.ParamByName('GEN_VARIAC').AsString := qryCadNfm.FieldByName('NFM_VARIAC').AsString;
  qryGen.ParamByName('GEN_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryGen.ParamByName('GEN_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
  qryGen.ParamByName('GEN_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
  qryGen.ParamByName('GEN_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
  qryGen.ParamByName('GEN_NACION').AsString := qryCadNfm.FieldByName('NFM_NACION').AsString;
  qryGen.ParamByName('GEN_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  qryGen.ParamByName('GEN_VERSAO').AsString := qryCadNfm.FieldByName('NFM_VERSAO').AsString;
  qryGen.ParamByName('GEN_OBSERV').AsString := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
  qryGen.ParamByName('GEN_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  qryGen.ParamByName('GEN_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

  For intCont := 1 To 15 Do
  Begin
    If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
      Break;

    qryGen.ParamByName('GEN_FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
    qryGen.ParamByName('GEN_QTDC' + fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat;
  End;

  qryGen.ExecSQL;
  Result := True;
end;

function TGeneral.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT * FROM GEN_CADNFM';
  qryGen.Open;

  pRegistraAcao('Processando cadastro de novas fórmulas...');
  While Not qryGen.Eof Do
  Begin
    fGravaNovaFormula(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas fórmulas processado com sucesso!');
  FreeAndNil(qryGen);
  Result := True;
end;

function TGeneral.fProcessarArquivos: Boolean;
begin
  Result := fProcessarCadBas
            And fProcessarCadMon
            And fProcessarCadGen;
end;

function TGeneral.fProcessarCadBas: Boolean;
  Var
    qryAdoCadBas: TADOQuery;
    qryCadbas: TUniQuery;
begin

  Try
    qryAdoCadBas := TADOQuery.Create(Nil);

    qryAdoCadBas.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + FstrPath +
      ';Persist Security Info=True';

    qryAdoCadBas.SQL.Add(' SELECT ');
    qryAdoCadBas.SQL.Add('   BASE.CD_BASE, ');
    qryAdoCadBas.SQL.Add('   BASE.DC_BASE, ');
    qryAdoCadBas.SQL.Add('   BASE.CD_ORDEM, ');
    qryAdoCadBas.SQL.Add('   BASE.NM_PESO_ESPECIFICO, ');
    qryAdoCadBas.SQL.Add('   UNIDADE.NM_CAPACIDADE ');
    qryAdoCadBas.SQL.Add(' FROM BASE, ');
    qryAdoCadBas.SQL.Add('   ESTOQUE, ');
    qryAdoCadBas.SQL.Add('   UNIDADE ');
    qryAdoCadBas.SQL.Add(' WHERE BASE.CD_BASE = ESTOQUE.CD_BASE ');
    qryAdoCadBas.SQL.Add('     AND ESTOQUE.CD_UNIDADE = UNIDADE.CD_UNIDADE ');
    qryAdoCadBas.SQL.Add(' ORDER BY BASE.CD_BASE ');
    qryAdoCadBas.Open;

    qryCadbas := fCriaQuery();
    qryCadbas.SQL.Add(' INSERT INTO GEN_CADBAS ');
    qryCadbas.SQL.Add('             (AUTOINCREM, ');
    qryCadbas.SQL.Add('              BAS_CODBAS, ');
    qryCadbas.SQL.Add('              BAS_DESCRI, ');
    qryCadbas.SQL.Add('              BAS_PESESP, ');
    qryCadbas.SQL.Add('              BAS_ORDEM_, ');
    qryCadbas.SQL.Add('              BAS_I_P_I_, ');
    qryCadbas.SQL.Add('              BAS_ICMS__, ');
    qryCadbas.SQL.Add('              BAS_EMBALA) ');
    qryCadbas.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadbas.SQL.Add('         :CODBAS, ');
    qryCadbas.SQL.Add('         :DESCRI, ');
    qryCadbas.SQL.Add('         :PESESP, ');
    qryCadbas.SQL.Add('         :ORDEM_, ');
    qryCadbas.SQL.Add('         :I_P_I_, ');
    qryCadbas.SQL.Add('         :ICMS__, ');
    qryCadbas.SQL.Add('         :EMBALA); ');

    pRegistraAcao('Processando cadastro de bases...');
    While Not qryAdoCadBas.Eof Do
    Begin
      qryCadbas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GEN_CADBAS', VS_strCodEmp);
      qryCadbas.ParamByName('CODBAS').AsString := qryAdoCadBas.FieldByName('CD_BASE').AsString;
      qryCadbas.ParamByName('DESCRI').AsString := qryAdoCadBas.FieldByName('DC_BASE').AsString;
      qryCadbas.ParamByName('PESESP').AsFloat := qryAdoCadBas.FieldByName('NM_PESO_ESPECIFICO').AsFloat / 1000;
      qryCadbas.ParamByName('ORDEM_').AsInteger := qryAdoCadBas.FieldByName('CD_ORDEM').AsInteger;
      qryCadbas.ParamByName('EMBALA').AsFloat := qryAdoCadBas.FieldByName('NM_CAPACIDADE').AsFloat * 1000;
      qryCadbas.ParamByName('I_P_I_').AsFloat := 5.0;
      qryCadbas.ParamByName('ICMS__').AsFloat := 7.52;

      Try
        qryCadbas.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('Base %s %.2f ML já está cadastrada', [
              qryAdoCadBas.FieldByName('CD_BASE').AsString,
              qryAdoCadBas.FieldByName('NM_CAPACIDADE').AsFloat * 1000]))
          Else
            Raise;
        End;
      End;

      qryAdoCadBas.Next;
      pRegistraProgresso(0, qryAdoCadBas.RecNo, qryAdoCadBas.RecordCount);
    End;
    pRegistraAcao('Cadastro de bases processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGeneral.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TGeneral.fProcessarCadGen: Boolean;
  Var
    qryAdoCadFormula: TADOQuery;
    qryCadGen: TUniQuery;

    strCodigo: String;
    strVariacao: String;
    intForm: Integer;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadGen.Params.Count - 1 Do
    Begin
      qryCadGen.Params.Items[i].Value := Null;
    End;
  End;
begin

  Try
    qryAdoCadFormula := TADOQuery.Create(Nil);

    qryAdoCadFormula.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + FstrPath +
      ';Persist Security Info=True';

    qryAdoCadFormula.SQL.Add(' SELECT ');
    qryAdoCadFormula.SQL.Add('   FORMULA.CD_FORMULA, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.NM_VARIACAO, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.DC_FORMULA, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.CD_MONTADORA, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.NM_ANO_INICIO, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.NM_ANO_TERMINO, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.ID_NACIONAL, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.CD_COR_MONTADORA, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.NM_VERSAO, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.DC_TIPOS_VEICULOS, ');
    qryAdoCadFormula.SQL.Add('   FORMULA.CD_RELAC, ');
    qryAdoCadFormula.SQL.Add('   COMPOSICAO_FORMULA.CD_BASE, ');
    qryAdoCadFormula.SQL.Add('   COMPOSICAO_FORMULA.NM_QUANTIDADE ');
    qryAdoCadFormula.SQL.Add(' FROM FORMULA ');
    qryAdoCadFormula.SQL.Add('   INNER JOIN COMPOSICAO_FORMULA ');
    qryAdoCadFormula.SQL.Add('     ON FORMULA.CD_FORMULA = COMPOSICAO_FORMULA.CD_FORMULA ');
    qryAdoCadFormula.SQL.Add('       AND FORMULA.NM_VARIACAO = COMPOSICAO_FORMULA.NM_VARIACAO ');
    qryAdoCadFormula.SQL.Add(' ORDER BY FORMULA.CD_FORMULA, FORMULA.NM_VARIACAO ');
    qryAdoCadFormula.Open;

    qryCadGen := fCriaQuery();

    qryCadGen.SQL.Text := 'TRUNCATE TABLE GEN_CADGEN;';
    qryCadGen.ExecSQL;
    qryCadGen.SQL.Clear;

    qryCadGen.SQL.Add(' INSERT INTO GEN_CADGEN ');
    qryCadGen.SQL.Add('             (AUTOINCREM, ');
    qryCadGen.SQL.Add('              GEN_CODIGO, ');
    qryCadGen.SQL.Add('              GEN_VARIAC, ');
    qryCadGen.SQL.Add('              GEN_DESCRI, ');
    qryCadGen.SQL.Add('              GEN_CODMON, ');
    qryCadGen.SQL.Add('              GEN_ANOINI, ');
    qryCadGen.SQL.Add('              GEN_ANOFIN, ');
    qryCadGen.SQL.Add('              GEN_NACION, ');
    qryCadGen.SQL.Add('              GEN_CODCOR, ');
    qryCadGen.SQL.Add('              GEN_VERSAO, ');
    qryCadGen.SQL.Add('              GEN_OBSERV, ');
    qryCadGen.SQL.Add('              GEN_PRODUT, ');

    For intForm := 1 To 15 Do
    Begin
      qryCadGen.SQL.Add('              GEN_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadGen.SQL.Add('              GEN_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadGen.SQL.Add('              GEN_CODNFM) ');
    qryCadGen.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadGen.SQL.Add('         :GEN_CODIGO, ');
    qryCadGen.SQL.Add('         :GEN_VARIAC, ');
    qryCadGen.SQL.Add('         :GEN_DESCRI, ');
    qryCadGen.SQL.Add('         :GEN_CODMON, ');
    qryCadGen.SQL.Add('         :GEN_ANOINI, ');
    qryCadGen.SQL.Add('         :GEN_ANOFIN, ');
    qryCadGen.SQL.Add('         :GEN_NACION, ');
    qryCadGen.SQL.Add('         :GEN_CODCOR, ');
    qryCadGen.SQL.Add('         :GEN_VERSAO, ');
    qryCadGen.SQL.Add('         :GEN_OBSERV, ');
    qryCadGen.SQL.Add('         :GEN_PRODUT, ');

    For intForm := 1 To 15 Do
    Begin
      qryCadGen.SQL.Add('         :GEN_FORM' + fStrZero(intForm, 2) + ', ');
      qryCadGen.SQL.Add('         :GEN_QTDC' + fStrZero(intForm, 2) + ', ');
    End;

    qryCadGen.SQL.Add('         :GEN_CODNFM); ');

    strCodigo := '';
    strVariacao := '';

    pRegistraAcao('Processando cadastro de cores...');

    While Not qryAdoCadFormula.Eof Do
    Begin
      Limpar;
      strCodigo := qryAdoCadFormula.FieldByName('CD_FORMULA').AsString;
      strVariacao := qryAdoCadFormula.FieldByName('NM_VARIACAO').AsString;

      qryCadGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GEN_CADGEN', VS_strCodEmp);
      qryCadGen.ParamByName('GEN_CODIGO').AsString := qryAdoCadFormula.FieldByName('CD_FORMULA').AsString;
      qryCadGen.ParamByName('GEN_VARIAC').AsString := qryAdoCadFormula.FieldByName('NM_VARIACAO').AsString;
      qryCadGen.ParamByName('GEN_DESCRI').AsString := qryAdoCadFormula.FieldByName('DC_FORMULA').AsString;
      qryCadGen.ParamByName('GEN_CODMON').AsString := qryAdoCadFormula.FieldByName('CD_MONTADORA').AsString;
      
      If qryAdoCadFormula.FieldByName('NM_ANO_INICIO').AsInteger > 0 Then
        qryCadGen.ParamByName('GEN_ANOINI').AsString := qryAdoCadFormula.FieldByName('NM_ANO_INICIO').AsString;

      If qryAdoCadFormula.FieldByName('NM_ANO_TERMINO').AsInteger > 0 Then
        qryCadGen.ParamByName('GEN_ANOFIN').AsString := qryAdoCadFormula.FieldByName('NM_ANO_TERMINO').AsString;

      qryCadGen.ParamByName('GEN_NACION').AsString := IfThen(qryAdoCadFormula.FieldByName('ID_NACIONAL').AsBoolean, 'S', 'N');
      qryCadGen.ParamByName('GEN_CODCOR').AsString := qryAdoCadFormula.FieldByName('CD_COR_MONTADORA').AsString;
      qryCadGen.ParamByName('GEN_VERSAO').AsString := qryAdoCadFormula.FieldByName('NM_VERSAO').AsString;
      qryCadGen.ParamByName('GEN_OBSERV').AsString := qryAdoCadFormula.FieldByName('DC_TIPOS_VEICULOS').AsString;
      qryCadGen.ParamByName('GEN_PRODUT').AsString := fGetNomeProduto(qryAdoCadFormula.FieldByName('CD_FORMULA').AsString);

      intForm := 1;

      While (strCodigo = qryAdoCadFormula.FieldByName('CD_FORMULA').AsString)
        And (strVariacao = qryAdoCadFormula.FieldByName('NM_VARIACAO').AsString)
        And (Not qryAdoCadFormula.Eof) Do
      Begin
        qryCadGen.ParamByName('GEN_FORM' + fStrZero(intForm, 2)).AsString := qryAdoCadFormula.FieldByName('CD_BASE').AsString;
        qryCadGen.ParamByName('GEN_QTDC' + fStrZero(intForm, 2)).AsFloat := qryAdoCadFormula.FieldByName('NM_QUANTIDADE').AsFloat;

        qryAdoCadFormula.Next;
        intForm := intForm + 1;
        pRegistraProgresso(0, qryAdoCadFormula.RecNo, qryAdoCadFormula.RecordCount);
      End;

      qryCadGen.ExecSQL;
    End;
    pRegistraAcao('Cadastro de cores processado com sucesso!');
    pRegistraAcao('Processando cadastro de novas fórmulas...');
    

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGeneral.fProcessarCadGen]');
      Result := False
    End;
  End;
end;

function TGeneral.fProcessarCadMon: Boolean;
  Var
    qryAdoCadMon: TADOQuery;
    qryCadMon: TUniQuery;
begin


  Try
    qryAdoCadMon := TADOQuery.Create(Nil);

    qryAdoCadMon.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=' + FstrPath +
      ';Persist Security Info=True';

    qryAdoCadMon.SQL.Add(' SELECT ');
    qryAdoCadMon.SQL.Add('   CD_MONTADORA, ');
    qryAdoCadMon.SQL.Add('   DC_MONTADORA ');
    qryAdoCadMon.SQL.Add(' FROM MONTADORA ');
    qryAdoCadMon.Open;

    qryCadMon := fCriaQuery();

    qryCadMon.SQL.Add(' INSERT INTO GEN_CADMON ');
    qryCadMon.SQL.Add('             (AUTOINCREM, ');
    qryCadMon.SQL.Add('              MON_CODMON, ');
    qryCadMon.SQL.Add('              MON_DESCRI) ');
    qryCadMon.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadMon.SQL.Add('         :MON_CODMON, ');
    qryCadMon.SQL.Add('         :MON_DESCRI); ');

    pRegistraAcao('Processando cadastro de montadoras ...');

    While Not qryAdoCadMon.Eof Do
    Begin                                  
      qryCadMon.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GEN_CADMON', VS_strCodEmp);
      qryCadMon.ParamByName('MON_CODMON').AsString := qryAdoCadMon.FieldByName('CD_MONTADORA').AsString;
      qryCadMon.ParamByName('MON_DESCRI').AsString := qryAdoCadMon.FieldByName('DC_MONTADORA').AsString;

      Try
        qryCadMon.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('A Montadora %s - %s já está cadastrada!', [
              qryAdoCadMon.FieldByName('CD_MONTADORA').AsString,
              qryAdoCadMon.FieldByName('DC_MONTADORA').AsString]))
          Else
            Raise;
        End;
      End;

      qryAdoCadMon.Next;
      pRegistraProgresso(0, qryAdoCadMon.RecNo, qryAdoCadMon.RecordCount);
    End;
    pRegistraAcao('Cadastro de montadoras processado com sucesso!');
    Result := True;
    
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGeneral.fProcessarCadMon]');
      Result := False
    End;
  End;
end;

procedure TGeneral.SetstrPath(const Value: String);
begin
  FstrPath := Value;
end;

end.
