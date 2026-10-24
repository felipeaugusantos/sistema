unit untFuturaDinamica;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, untTintadeMaquina, untIConfTinta;

Type
  TFuturaOpcao = (TFuturaGeraBases, TFuturaGeraColorantes, TFuturaGeraTintas);
  TFuturaOpcoes = set of TFuturaOpcao;

  TFuturaImobiliariaDinamica = class(TTintadeMaquina)
  private
    strPat : String;
    FOpcoes: TFuturaOpcoes;
    conf   : IConfTinta;

    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadFut: Boolean;

    procedure SetOpcoes(const Value: TFuturaOpcoes);

  public
    constructor Create(AOwner: TComponent); override;
    function fProcessaArquivos: Boolean;
    function fGravaCadNfms: Boolean; 
    class function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
    function fGravarNovasFormulas: Boolean; override;
    class procedure pDeletaNovaFormula(strCodNfm: String);

  published
    property Opcoes: TFuturaOpcoes read FOpcoes write SetOpcoes;

  End;

  function fIntInicial(strProdut: String): Integer;
  function fIntFinal(strProdut: String): Integer;
  function fRetornaFator(strFator: String): Double;

implementation

uses untFuncoesSimples, untFuncTinta, StrUtils, untModulo;

{ TFuturaImobiliariaDinamica }

constructor TFuturaImobiliariaDinamica.Create(AOwner: TComponent);
begin
  conf   := fGetConfTinta('FUT');
  strPat := conf.fGet('PATFUT'); //fArqIniTinta(0, 'FUTURA', 'PATFUT', '');
end;

function TFuturaImobiliariaDinamica.fGravaCadNfms: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM FUT_CADFUT WHERE FUT_REFERE IN (SELECT NFM_CODNFM FROM FUT_CADNFM)';
  qryGen.ExecSQL;

  qryGen.SQL.Text := 'SELECT * FROM FUT_CADNFM';
  qryGen.Open;

  pRegistraAcao('Cadastrando Novas Formulas...');
  While Not qryGen.Eof Do
  Begin
    fGravaNovaFormula(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Novas Formulas cadastradas com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

class function TFuturaImobiliariaDinamica.fGravaNovaFormula(
  qryNfm: TUniQuery): Boolean;
  Var
    qryGen : TUniQuery;
    intCont: Integer;
    intForm: Integer;
  Const
    arrUnidades: Array[1..3] of String = ('QT', 'GL', 'LA');
    arrFatores: Array[1..3] of Integer = (1, 4, 20);
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT * FROM FUT_CADFUT WHERE FALSE ';
  qryGen.Open;

  For intCont := 1 To 3 Do
  Begin
    qryGen.Insert;
    qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FUT_CADFUT', VS_strCodEmp);
    qryGen.FieldByName('FUT_CODEMP').AsString := VS_strCodEmp;
    qryGen.FieldByName('FUT_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.FieldByName('FUT_REFERE').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
    qryGen.FieldByName('FUT_UNIDAD').AsString := arrUnidades[intCont];

    For intForm := 1 To 10 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_FORM' + fStrZero(intForm, 2)).AsString) Then
        Break;

      qryGen.FieldByName('FUT_FORM' + fStrZero(intForm, 2)).AsString := qryNfm.FieldByName('NFM_FORM' + fStrZero(intForm, 2)).AsString;
      qryGen.FieldByName('FUT_QTDB' + fStrZero(intForm, 2)).AsFloat := arrFatores[intCont] * qryNfm.FieldByName('NFM_QTDC' + fStrZero(intForm, 2)).AsFloat;
    End;

    qryGen.FieldByName('FUT_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
    qryGen.FieldByName('FUT_SPRODU').AsString := qryNfm.FieldByName('NFM_SPRODU').AsString;
    qryGen.FieldByName('FUT_CODBAS').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
    qryGen.Post;
  End;

  FreeAndNil(qryGen);
  Result := True;
end;

function TFuturaImobiliariaDinamica.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaCadNfms;
end;

function TFuturaImobiliariaDinamica.fProcessaArquivos: Boolean;
begin
  Result := True;
  //[TFuturaGeraBases, TFuturaGeraColorantes, TFuturaGeraTintas]
  If TFuturaGeraBases in Opcoes Then
    Result := Result And fProcessaCadBas;

  If TFuturaGeraColorantes in Opcoes Then
    Result := Result And fProcessaCadCol;

  If TFuturaGeraTintas in Opcoes Then
    Result := Result And fProcessaCadFut;
end;

function TFuturaImobiliariaDinamica.fProcessaCadBas: Boolean;
  Var
    qryPaths: TUniQuery;
    qryCadBas: TUniQuery;
    qryCadBasDbf: TUniQuery;

    arrUnidades: Array[1..3] of String;
    intCont: Integer;

    procedure Limpar();
    Begin
      If Assigned(qryPaths) Then FreeAndNil(qryPaths);
      If Assigned(qryCadBas) Then FreeAndNil(qryCadBas);
      If Assigned(qryCadBasDbf) Then FreeAndNil(qryCadBasDbf);
    End;
begin

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Text := 'SELECT * FROM FUT_CADBAS';
  qryCadbas.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('FUT_CADBAS', VS_strCodEmp);

//  qryPaths := TQuery.Create(Self);
//  qryPaths.DatabaseName := strPat;
//  qryPaths.SQL.Text := 'SELECT * FROM PRODUCTS.DBF';
//  qryPaths.Open;

  arrUnidades[1] := conf.fGet('FUTQUA'); //fArqIniTinta(0, 'FUTURA', 'FUTQUA', '');
  arrUnidades[2] := conf.fGet('FUTGAL'); //fArqIniTinta(0, 'FUTURA', 'FUTGAL', '');
  arrUnidades[3] := conf.fGet('FUTLAT'); //fArqIniTinta(0, 'FUTURA', 'FUTLAT', '');

  qryCadBasDbf := fCriaQuery(Self, frmModulo.DataDBF);

  pRegistraAcao('Cadastrando bases...');
//  While Not qryPaths.Eof Do
//  Begin
    qryCadBasDbf.Close;
    qryCadBasDbf.SQL.Text := 'SELECT DISTINCT BASES.CODE, PRODUCTS.DESCR PDESCR, BASES.DESCR BASE FROM ' + strPat + '\BASES.DBF, ' + strPat + '\PRODUCTS.DBF ';
    qryCadBasDbf.Open;

    While Not qryCadBasDbf.Eof Do
    Begin

      For intCont := 1 To 3 Do
      Begin

        If Not qryCadBas.Locate('BAS_CODFML;BAS_CODBAS;BAS_DESCRI;BAS_PRODUT;BAS_CODUNI',
          VarArrayOf([UpperCase(Trim(qryCadBasDbf.FieldByName('CODE').AsString)),
          UpperCase(Trim(qryCadBasDbf.FieldByName('CODE').AsString)),
          UpperCase(Trim(qryCadBasDbf.FieldByName('BASE').AsString)),
          UpperCase(Trim(qryCadBasDbf.FieldByName('PDESCR').AsString)),
          arrUnidades[intCont]]), []) Then
        Begin
          //Se for textura entao nao gera unidade quarto
          If (Pos(LeftStr(UpperCase(Trim(qryCadBasDbf.FieldByName('PDESCR').AsString)),3), '306_307_308_') > 0) And (intCont = 1) Then
            Continue;

          qryCadBas.Insert;

          qryCadBas.FieldByName('BAS_CODFML').AsString := UpperCase(Trim(qryCadBasDbf.FieldByName('CODE').AsString));
          qryCadBas.FieldByName('BAS_CODBAS').AsString := UpperCase(Trim(qryCadBasDbf.FieldByName('CODE').AsString));
          qryCadBas.FieldByName('BAS_DESCRI').AsString := UpperCase(Trim(qryCadBasDbf.FieldByName('BASE').AsString));
          qryCadBas.FieldByName('BAS_PRODUT').AsString := UpperCase(Trim(qryCadBasDbf.FieldByName('PDESCR').AsString));
          qryCadBas.FieldByName('BAS_CODUNI').AsString := arrUnidades[intCont];
          qryCadbas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
          qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FUT_CADBAS', VS_strCodEmp);

          qryCadBas.Post;
          pRegistraProgresso(0, qryCadBasDbf.RecNo * 3, qryCadBasDbf.RecordCount * 3);
        End;

      End;

      qryCadBasDbf.Next;
    End;

//    qryPaths.Next;
//  End;
  Limpar();
  Result := True;
  pRegistraAcao('Cadastro de bases realizado com sucesso!');
end;

function TFuturaImobiliariaDinamica.fProcessaCadCol: Boolean;
  Var
    qryCadColDbf: TUniQuery;
    qryCadCol: TUniQuery;

    procedure Limpar();
    Begin
      If Assigned(qryCadColDbf) Then FreeAndNil(qryCadColDbf);
      If Assigned(qryCadCol) Then FreeAndNil(qryCadCol);
    End;
begin

  qryCadColDbf := fCriaQuery(Self, frmModulo.DataDBF);
  qryCadColDbf.SQL.Text := 'SELECT * FROM ' + strPat + '\CNTS.DBF';
  qryCadColDbf.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Text := 'SELECT * FROM FUT_CADCOL';
  qryCadCol.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('FUT_CADCOL', VS_strCodEmp);

  pRegistraAcao('Cadastrando colorantes...');
  While Not qryCadColDbf.Eof Do
  Begin
    If Not qryCadCol.Locate('COL_CODCOL', qryCadColDbf.FieldByName('CODE').AsString, []) Then
    Begin

      qryCadCol.Insert;

      qryCadCol.FieldByName('COL_CODCOL').AsString := UpperCase(Trim(qryCadColDbf.FieldByName('CODE').AsString));
      qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FUT_CADCOL', VS_strCodEmp);

      qryCadCol.Post;
      pRegistraProgresso(0, qryCadColDbf.RecNo, qryCadColDbf.RecordCount);
      qryCadCol.Next;

    End;
    qryCadColDbf.Next;
  End;

  Limpar();
  Result := True;
  pRegistraAcao('Cadastro de colorantes realizado com sucesso!');

end;

function TFuturaImobiliariaDinamica.fProcessaCadFut: Boolean;
  Var
    arrUnidades: Array [1..4] of String;

    qryCadColDbf: TUniQuery;
    qryCadEmbDbf: TUniQuery;
    qryPaths : TUniQuery;
    qrySubProds: TUniQuery;
    qryFrm: TUniQuery;
    qryRuler: TUniQuery;
    qryCadBasDbf: TUniQuery;

    qryCadFut: TUniQuery;

    intCont: Integer;
    intForm: Integer;

    strForm: String;
    strCol: String;

    fltQtd: Double;

    fltFator: Double;

    strProduto: string;
    strSubProduto: string;
    strBase: string;

    procedure Limpar();
    Begin
      If Assigned(qryCadColDbf) Then FreeAndNil(qryCadColDbf);
      If Assigned(qryCadEmbDbf) Then FreeAndNil(qryCadEmbDbf);
      If Assigned(qryPaths) Then FreeAndNil(qryPaths);
      If Assigned(qrySubProds) Then FreeAndNil(qrySubProds);
      If Assigned(qryFrm) Then FreeAndNil(qryFrm);
      If Assigned(qryRuler) Then FreeAndNil(qryRuler);
      If Assigned(qryCadBasDbf) Then FreeAndNil(qryCadBasDbf);
      If Assigned(qryCadFut) Then FreeAndNil(qryCadFut);
    End;
begin

  arrUnidades[1] := conf.fGet('FUTQUA'); //fArqIniTinta(0, 'FUTURA', 'FUTQUA', '');
  arrUnidades[2] := conf.fGet('FUTGAL'); //fArqIniTinta(0, 'FUTURA', 'FUTGAL', '');
  arrUnidades[3] := conf.fGet('FUTLAT'); //fArqIniTinta(0, 'FUTURA', 'FUTLAT', '');

  qryCadColDbf := fCriaQuery(Self, frmModulo.DataDBF);
  qryCadColDbf.SQL.Text := 'SELECT DISTINCT ID, DESCR FROM ' + strPat + '\CNTS.DBF';
  qryCadColDbf.Open;

  qryCadEmbDbf := fCriaQuery(Self, frmModulo.DataDBF);
  qryCadEmbDbf.SQL.Text := 'SELECT ID, DESCR, NOM_Q QTD FROM ' + strPat + '\CANS.DBF';
  qryCadEmbDbf.Open;

  qryPaths := fCriaQuery(Self, frmModulo.DataDBF);
  qryPaths.SQL.Text := 'SELECT ID, PATH, DESCR FROM ' + strPat + '\PRODUCTS.DBF';
  qryPaths.Open;

  qrySubProds := fCriaQuery(Self, frmModulo.DataDBF);

  qryFrm := fCriaQuery(Self, frmModulo.DataDBF);

  qryRuler := fCriaQuery(Self, frmModulo.DataDBF);

  qryCadBasDbf := fCriaQuery(Self, frmModulo.DataDBF);
  qryCadBasDbf.SQL.Text := 'SELECT * FROM ' + strPat + '\BASES.DBF';
  qryCadBasDbf.Open;

  qryCadFut := fCriaQuery(Self);
  qryCadFut.SQL.Text := 'TRUNCATE TABLE FUT_CADFUT';
  qryCadFut.ExecSQL;

  qryCadFut.SQL.Text := 'SELECT * FROM FUT_CADFUT';
  qryCadFut.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('FUT_CADFUT', VS_strCodEmp);

  pRegistraAcao('Cadastrando tintas...');
  While Not qryPaths.Eof Do
  Begin
    qrySubProds.Close;
    qrySubProds.SQL.Text := 'SELECT ID, DESCR, PATH FROM ' +
      qryPaths.FieldByName('PATH').AsString + '\SUBPRODS ORDER BY ID';
    qrySubProds.Open;

    While Not qrySubProds.Eof Do
    Begin
      If FileExists(strPat + '\' +
      qryPaths.FieldByName('PATH').AsString + '\' +
      qrySubProds.FieldByName('PATH').AsString + '\' +
      'FRM.DBF') Then
      Begin
        qryFrm.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\' +
        qrySubProds.FieldByName('PATH').AsString + '\FRM';
      End
      Else
      Begin
        qryFrm.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\FRM';
      End;

      qryFrm.Open;
      qryFrm.First;

      //Ruler
      If FileExists(strPat + '\' +
      qryPaths.FieldByName('PATH').AsString + '\' +
      qrySubProds.FieldByName('PATH').AsString + '\' +
      'RULER.DBF') Then
      Begin
        qryRuler.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\' +
        qrySubProds.FieldByName('PATH').AsString + '\RULER';
      End
      Else
      Begin
        qryRuler.SQL.Text := 'SELECT * FROM ' + qryPaths.FieldByName('PATH').AsString + '\RULER';
      End;

      qryRuler.Open;
      qryRuler.First;

      pRegistraAcao('Cadastrando ' + UpperCase(Trim(qryPaths.FieldByName('DESCR').AsString)) + ' - ' + UpperCase(Trim(qrySubProds.FieldByName('DESCR').AsString)) + '...');

      While Not qryFrm.Eof Do
      Begin

        If Not qryCadBasDbf.Locate('ID', qryFrm.FieldByName('BASE_ID').AsString, []) Then
        Begin
          qryCadBasDbf.Locate('ID', qryFrm.FieldByName('BASE_ID').AsString, []);
        End;

        For intCont := fIntInicial(LeftStr(qryPaths.FieldByName('DESCR').AsString, 3)) To fIntFinal(LeftStr(qryPaths.FieldByName('DESCR').AsString, 3)) Do
        Begin
          qryCadFut.Insert;

          qryCadFut.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FUT_CADFUT', VS_strCodEmp);
          qryCadFut.FieldByName('FUT_CODEMP').AsString := VS_strCodEmp;
          qryCadFut.FieldByName('FUT_DESCRI').AsString := UpperCase(Trim(qryPaths.FieldByName('DESCR').AsString)) + ' ' + UpperCase(Trim(qryCadBasDbf.FieldByName('DESCR').AsString));
          qryCadFut.FieldByName('FUT_REFERE').AsString := UpperCase(Trim(qryFrm.FieldByName('KEY1').AsString));
          qryCadFut.FieldByName('FUT_UNIDAD').AsString := arrUnidades[intCont];
          qryCadFut.FieldByName('FUT_PRODUT').AsString := UpperCase(Trim(qryPaths.FieldByName('DESCR').AsString));
          qryCadFut.FieldByName('FUT_SPRODU').AsString := UpperCase(Trim(qrySubProds.FieldByName('DESCR').AsString));
          qryCadFut.FieldByName('FUT_CODBAS').AsString := UpperCase(Trim(qryCadBasDbf.FieldByName('CODE').AsString));

          fltFator := 29.57 / 384;

          strProduto := LeftStr(qryCadFut.FieldByName('FUT_PRODUT').AsString, 3);
          strSubProduto := qryCadFut.FieldByName('FUT_SPRODU').AsString;
          strBase := qryCadFut.FieldByName('FUT_CODBAS').AsString;

          if strProduto = '513' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                fltFator := fltFator * 0.9
              else if strBase = 'B' then
                fltFator := fltFator * 0.9
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
            begin
              fltFator := fltFator * 1;
            end;
          end
          else if strProduto = '511' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                fltFator := fltFator * 0.9
              else if strBase = 'B' then
                fltFator := fltFator * 0.9
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
            begin
              fltFator := fltFator * 1;
            end;
          end
          else if strProduto = '514' then
          begin
            fltFator := fltFator * 1;
          end
          else if strProduto = '504' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                  fltFator := fltFator * 0.8
              else if strBase = 'B' then
                fltFator := fltFator * 0.8
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
              fltFator := fltFator * 1;
          end
          else if strProduto = '500' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                  fltFator := fltFator * 1
              else if strBase = 'B' then
                fltFator := fltFator * 0.8
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
              fltFator := fltFator * 1
          end
          else if strProduto = '502' then
          begin
            if strBase = 'A' then
                fltFator := fltFator * 0.8
            else if strBase = 'B' then
              fltFator := fltFator * 0.5
            else if strBase = 'C' then
              fltFator := fltFator * 1
          end
          else if strProduto = '501' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                  fltFator := fltFator * 0.8
              else if strBase = 'B' then
                fltFator := fltFator * 0.8
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
              fltFator := fltFator * 1;
          end
          else if strProduto = '509' then
          begin
            if strSubProduto = 'MAGIA DAS CORES' then
            begin
              if strBase = 'A' then
                fltFator := fltFator * 0.75
              else if strBase = 'B' then
                fltFator := fltFator * 0.7
              else if strBase = 'C' then
                fltFator := fltFator * 1
            end
            else
              fltFator := fltFator * 1;
          end
          else if strProduto = '408' then
          begin
            fltFator := fltFator * 1;
          end
          else if strProduto = '308' then
          begin
            fltFator := fltFator * 1;
          end
          else if strProduto = '307' then
          begin
            fltFator := fltFator * 1;
          end
          else if strProduto = '306' then
          begin
            fltFator := fltFator * 1;
          end
          else if strProduto = '515' then
          begin
            If (Not qryRuler.Locate('PTR_ID', qryFrm.FieldByName('BASE_ID').AsString, [])) Then
              fltFator := fltFator * 1
            Else
              fltFator := fltFator * fRetornaFator(Trim(qryRuler.FieldByName('RULE').AsString));
          end;

          intForm := 1;

          If (Not AnsiEndsText(',', qryFrm.FieldByName('FORMULA').AsString)) Then
            strForm := qryFrm.FieldByName('FORMULA').AsString + ',';

          While Not fEmptyStr(strForm) Do
          Begin
            strCol := fPadL(Copy(strForm, 1, Pos(',', strForm) - 1), 5);
            qryCadColDbf.Locate('ID', strCol, []);
            qryCadFut.FieldByName('FUT_FORM' + fStrZero(intForm, 2)).AsString := UpperCase(Trim(qryCadColDbf.FieldByName('DESCR').AsString));

            strForm := Copy(strForm, Pos(',', strForm) + 1, Length(strForm));
            fltQtd := fStrToFloat(AnsiReplaceStr(Copy(strForm, 1, Pos(',', strForm) - 1), '.', ','));

            If (Pos(strProduto,'500_502_208_308_306_515_307_') > 0) Then //produtos especificos
            Begin
              If (Pos(strProduto,'500_502_208_515_') > 0) Then
              Begin
                If intCont = 1 Then
                  fltQtd := fltQtd * fltFator
                Else If intCont = 2 Then
                Begin
                  fltQtd := fFormataFloat(fltQtd * fltFator * 4, 2);
                 {If strSubProduto = 'MAGIA DAS CORES' Then
                   fltQtd := fFormataFloat(fltQtd * fltFator * 4, 2)
                 Else
                   fltQtd := fFormataFloat(fltQtd * fltFator * 5, 2);}
                End;
              End
              Else If (Pos(strProduto,'306_308_') > 0) Then
              Begin
                If intCont = 2 Then
                  fltQtd := fltQtd * fltFator
                Else If intCont = 3 Then
                  fltQtd := fFormataFloat(fltQtd * fltFator * 5, 2);
              End
              Else If (Pos(strProduto,'307_') > 0) Then  // textura rustica   GL --> 3,24L - LA --> 14L
              Begin
                If intCont = 2 Then
                  fltQtd := fltQtd * fltFator
                Else If intCont = 3 Then
                  fltQtd := fFormataFloat(fltQtd * fltFator * 4.321, 2);
              End;
            End
            Else
            Begin
              If intCont = 1 Then
                fltQtd := fltQtd * fltFator
              Else If intCont = 2 Then
               fltQtd := fFormataFloat(fltQtd * fltFator * 4, 2)
              Else If intCont = 3 Then
               fltQtd := fFormataFloat(fltQtd * fltFator * 20, 2);
            End;

            fltQtd := fFormataFloat(fltQtd, 2);

            qryCadFut.FieldByName('FUT_QTDB' + fStrZero(intForm, 2)).AsFloat := fltQtd;
            strForm := Copy(strForm, Pos(',', strForm) + 1, Length(strForm));
            intForm := intForm + 1;

          End;

          qryCadFut.Post;
        End;

        qryFrm.Next;
        pRegistraProgresso(0, qryFrm.RecNo, qryFrm.RecordCount);
      End;
      qrySubProds.Next;
    End;
    qryPaths.Next;
  End;
  Result := True;
  Limpar();
  pRegistraAcao('Cadastro de tintas realizado com sucesso!');
end;

class procedure TFuturaImobiliariaDinamica.pDeletaNovaFormula(strCodNfm: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    qryAux.SQL.Clear;
    qryAux.Close;
    qryAux.SQL.Text := 'DELETE '+
                       '  FROM FUT_CADFUT '+
                       ' WHERE FUT_REFERE = :REFERE ';

    qryAux.ParamByName('REFERE').AsString := strCodNfm;

    qryAux.ExecSQl;
  finally
    FreeAndNil(qryAux);
  end;

end;

procedure TFuturaImobiliariaDinamica.SetOpcoes(const Value: TFuturaOpcoes);
begin
  FOpcoes := Value;
end;

{**************************************************}
{* NOVA REGRA PASSADA PELA FUTURA                 *}
{* OS PRODUTOS ABAIXO EXISTEM REGRAS POR PRODUTOS *}
{* 208 - VERNIZ                                   *}
{* 500, 502 - ESMALTE                             *}
{* QT ; GL                                        *}

{* 308, 306 TEXTURA                               *}
{* GL ; LA                                        *}

{* 515 - GEL                                      *}
{* QT                                             *}

{* 307 - TEXTURA RUSTICA                          *}
{* GL -> 3,24 ; LA -> 14                          *}
{***********************************************AC*}
function fIntInicial(strProdut: String): Integer;
begin
  Result := 1;
  If (Pos(strProdut, '208_500_502_515_') > 0) Then
    Result := 1
  Else If (Pos(strProdut, '306_307_308_') > 0) Then
    Result := 2;
end;

function fIntFinal(strProdut: String): Integer;
begin
  Result := 3;
  If (Pos(strProdut, '515_') > 0) Then
    Result := 1
  Else If (Pos(strProdut, '208_500_502_') > 0) Then
    Result := 2
  Else If (Pos(strProdut, '306_307_308_') > 0) Then
    Result := 3;
end;

function fRetornaFator(strFator: String): Double;
begin
  If Pos('.', strFator) > 0 Then
    Result := fStrToFloat(AnsiReplaceStr(strFator,'.',','))
  Else
    Result := fStrToFloat(strFator);
end;

end.
