unit untMazaImobiliariaDinamica;

interface

uses
  SysUtils, Classes, UniClientDataSet, Uni ,Forms, DB, ADODB, DBClient, Variants,
  untTintadeMaquina, untIConfTinta;

Type
  TMazaImobiliariaOpcao = (TMazaImobiliariaGeraBases, TMazaImobiliariaGeraColorantes, TMazaImobiliariaGeraTintas);
  TMazaImobiliariaOpcoes = set of TMazaImobiliariaOpcao;

  TMazaImobiliariaDinamica = class(TTintadeMaquina)
  private
    strPat    : String;
    FOpcoes   : TMazaImobiliariaOpcoes;
    conf      : IConfTinta;
    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    Planilhas : TStringList;
    strPatMzi : String;

    function fProcessaCadBas: Boolean;
    function fProcessaCadCol: Boolean;
    function fProcessaCadMzi: Boolean;

    procedure SetOpcoes(const Value: TMazaImobiliariaOpcoes);
    procedure pCarregarVariaveis(strPathFile : String );
    procedure pDestruirVariaveis;
    function fRetornarFator(StrEmbalagem : String) : Double;


  public
    constructor Create(AOwner: TComponent); override;
    function fProcessaArquivos: Boolean;
    function fGravaCadNfms: Boolean;
    class function fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
    function fGravarNovasFormulas: Boolean; override;
  published
    property Opcoes: TMazaImobiliariaOpcoes read FOpcoes write SetOpcoes;

  End;

  procedure pDeletaNovaFormulaDinamica(strCodPro: String);
  function fIntInicial(strProdut: String): Integer;
  function fIntFinal(strProdut: String): Integer;
  function fRetornaFator(strFator: String): Double;
  function fOncasParaMl(Oncas : String): Double;

  Const
    Arr_Produtos : Array[0..14] of String = ('ESMALTE BASE ÁGUA BRILHANTE',
                                             'TEXTURA LATECRYL (GALÃO)',
                                             'TEXTURA RISCADA H-REPELENTE (GALLONS)',
                                             'ACRÍLICO EXTRA',
                                             'ACRÍLICO PREMIUM ACETINADO',
                                             'ACRÍLICO PREMIUM SEMI-BRILHO',
                                             'ACRÍLICO PREMIUM ELÁSTICO',
                                             'ESMALTE SINTÉTICO BRILHANTE',
                                             'ESMALTE SINTETICO ACETINADO',
                                             'GEL ENVELHECEDOR',
                                             'SELADOR ACRÍLICO',
                                             'TEXTURA FINA H-REPELENTE (GALLONS)',
                                             'TEXTURA RUGOSA H-REPELENTE (GALLONS)',
                                             'ACRÍLICO ULTRA',
                                             'ACRÍLICO PREMIUM FOSCO' );

implementation

uses untFuncoesSimples, untFuncTinta, StrUtils;

{ TMazaImobiliariaDinamica }

constructor TMazaImobiliariaDinamica.Create(AOwner: TComponent);
begin
  conf      := fGetConfTinta('MZI');
  strPat    := conf.fGet('PATMZI');
  strPatMzi := conf.fGet('TXTMZI');
end;

function TMazaImobiliariaDinamica.fGravaCadNfms: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE '+
                     '  FROM MZI_CADMZI '+
                     ' WHERE MZI_CODMZI IN (SELECT NFM_CODNFM  '+
                     '                        FROM MZI_CADNFM)';
  qryGen.ExecSQL;

  qryGen.SQL.Text := 'SELECT * FROM MZI_CADNFM';
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

class function TMazaImobiliariaDinamica.fGravaNovaFormula(qryNfm: TUniQuery): Boolean;
  Var
    qryGen  : TUniQuery;
    qryEmb  : TUniQuery;
    intForm : Integer;
begin
  pDeletaNovaFormulaDinamica(qryNfm.FieldByName('NFM_CODNFM').AsString);

  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT * FROM MZI_CADMZI WHERE FALSE ';
  qryGen.Open;

  qryEmb := fCriaQuery(nil);
  qryEmb.SQL.Text := 'SELECT * FROM MZI_CADEMB ';
  qryEmb.Open;

  qryEmb.First;

  While not (qryEmb.Eof) do
  Begin
    qryGen.Insert;
    qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MZI_CADMZI', VS_strCodEmp);
    qryGen.FieldByName('MZI_CODEMP').AsString := VS_strCodEmp;
    qryGen.FieldByName('MZI_CODMZI').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
    qryGen.FieldByName('MZI_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
    qryGen.FieldByName('MZI_COLNUM').AsString := qryNfm.FieldByName('NFM_COLNUM').AsString;
    qryGen.FieldByName('MZI_COLNAM').AsString := qryNfm.FieldByName('NFM_COLNAM').AsString;
    qryGen.FieldByName('MZI_CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.FieldByName('MZI_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
    qryGen.FieldByName('MZI_CODUNI').AsString := qryEmb.FieldByName('EMB_UNIDAD').AsString;
    qryGen.FieldByName('MZI_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intForm := 1 To 20 Do
    Begin
      If fEmptyStr(qryNfm.FieldByName('NFM_CODC' + fStrZero(intForm, 2)).AsString) Then
        Break;

      qryGen.FieldByName('MZI_CODC' + fStrZero(intForm, 2)).AsString := qryNfm.FieldByName('NFM_CODC' + fStrZero(intForm, 2)).AsString;
      qryGen.FieldByName('MZI_QTDC' + fStrZero(intForm, 2)).AsFloat  := ((qryEmb.FieldByName('EMB_QTDEMB').AsFloat *
                                                                           qryNfm.FieldByName('NFM_QTDC' + fStrZero(intForm, 2)).AsFloat) / 1000);
    End;

    qryGen.Post;

    qryEmb.Next;
  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryEmb);

  Result := True;
end;

function TMazaImobiliariaDinamica.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaCadNfms;
end;



function TMazaImobiliariaDinamica.fProcessaArquivos: Boolean;
begin
  Result := True;

  If TMazaImobiliariaGeraBases in Opcoes Then
    Result := Result And fProcessaCadBas;

  If TMazaImobiliariaGeraColorantes in Opcoes Then
    Result := Result And fProcessaCadCol;

  If TMazaImobiliariaGeraTintas in Opcoes Then
    Result := Result And fProcessaCadMzi;
end;

function TMazaImobiliariaDinamica.fProcessaCadBas: Boolean;
var
  qryCadBas      : TUniQuery;
  qryCadEmb      : TUniQuery;
  intCont        : Integer;
  search_rec     : TSearchRec;
  strPathDirFile : String;
  intProgresso   : Integer;
begin

  Result  := 	true;

  intCont     := 0;

  If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
  Begin
    try
      pRegistraAcao(' Cadastrando as bases...');

      repeat
        strPathDirFile := (strPat + '\' + search_rec.Name);

        pRegistraAcao(' Processando o arquivo ' + search_rec.Name);

        If (Not FileExists(strPathDirFile)) Then
        Begin
          fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPat, ['&Ok']);
          Exit;
        End;

        pCarregarVariaveis(strPathDirFile);

        Excel.CommandText := 'SELECT [Base] ' + Format(' FROM [%s] ', [Planilhas.Strings[0]]);
        Excel.Open;

        qryCadBas := fCriaQuery;
        qryCadBas.SQL.Text := 'SELECT * FROM MZI_CADBAS';
        qryCadBas.Open;

        qryCadEmb := fCriaQuery;
        qryCadEmb.SQL.Text := ' SELECT DISTINCT EMB_UNIDAD AS UNID FROM MZI_CADEMB';
        qryCadEmb.Open;

        if(qryCadEmb.RecordCount = 0 )then
        begin
          fMensagem('ATENÇÃO', 'Não foi possível gerar as bases, verifique o cadastro de embalagem!', ['&Ok']);
          Result  := false;
          Exit;
        end;


        Excel.First;

        intProgresso := 0;

        While Not Excel.Eof Do
        Begin

          qryCadEmb.First;

          while not (qryCadEmb.eof) do
          begin

            If (not fEmptyStr(Excel.FieldByName('Base').AsString)) And
                  (not qryCadBas.Locate('BAS_CODBAS;BAS_DESCRI;BAS_CODUNI', VarArrayOf([Excel.FieldByName('Base').AsString,
                       Arr_Produtos[intCont], qryCadEmb.FieldByName('UNID').AsString]),[])) Then
            begin

              qryCadBas.Insert;

              qryCadBas.FieldByName('BAS_CODBAS').AsString := Excel.FieldByName('BASE').AsString;
              qryCadBas.FieldByName('BAS_DESCRI').AsString := Arr_Produtos[intCont];
              qryCadBas.FieldByName('BAS_CODUNI').AsString := qryCadEmb.FieldByName('UNID').AsString;
              qryCadBas.FieldByName('BAS_PRECUS').AsFloat  := 0;
              qryCadBas.FieldByName('BAS_MARGEM').AsFloat  := 0;
              qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := 0;
              qryCadBas.FieldByName('BAS_PRODUT').AsString := Arr_Produtos[intCont];
              qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
              qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MZI_CADBAS', VS_strCodEmp);
              qryCadBas.Post;


            end;

            qryCadEmb.Next;
          end;
            Inc(intProgresso);

            pRegistraProgresso(0,intProgresso,Excel.RecordCount);

          Excel.Next;
        End;

        pDestruirVariaveis;

        FreeAndNil(qryCadBas);
        FreeAndNil(qryCadEmb);

        Inc(intCont);

      until FindNext(search_rec) <> 0;

      FindClose(search_rec);

    except
      Result := false;
    end
  End
  else
    Result := false;

  if Result then
    pRegistraAcao('Cadastro de bases realizado com sucesso!')
  else
    pRegistraAcao('Não foi possível gerar o cadastro de bases!');
end;

function TMazaImobiliariaDinamica.fProcessaCadCol: Boolean;
var
  qryCadCol      : TUniQuery;
  search_rec     : TSearchRec;
  strPathDirFile : String;
  intProgresso   : Integer;
begin

  Result := true;

  If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
  Begin
    try
      pRegistraAcao(' Cadastrando os colorantes...');

      repeat
        intProgresso   := 0;

        strPathDirFile := (strPat + '\' + search_rec.Name);

        pRegistraAcao(' Processando o arquivo ' + search_rec.Name);

        If (Not FileExists(strPathDirFile)) Then
        Begin
          fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPat, ['&Ok']);
          Exit;
        End;

        pCarregarVariaveis(strPathDirFile);

        qryCadCol := fCriaQuery;
        qryCadCol.SQL.Text := 'SELECT * FROM MZI_CADCOL';
        qryCadCol.Open;

        Excel.Close;
        Excel.CommandText :=  'SELECT [Col1] ' + Format(' FROM [%s] ', [Planilhas.Strings[0]]) +
                              '       UNION '+
                              '         SELECT [Col2] '+ Format(' FROM [%s] ', [Planilhas.Strings[0]]) +
                              '       UNION '+
                              '         SELECT [Col3] '+ Format(' FROM [%s] ', [Planilhas.Strings[0]]) +
                              '       UNION '+
                              '         SELECT [Col4] '+ Format(' FROM [%s] ', [Planilhas.Strings[0]]);

        Excel.Open;
        Excel.First;

        While not Excel.Eof do
        begin
          if (Excel.Fields[0].AsString <> '') then
          begin
            If not qryCadCol.Locate('COL_CODCOL', Excel.Fields[0].AsString, []) Then
            Begin
              qryCadCol.Insert;
              qryCadCol.FieldByName('COL_CODCOL').AsString := Excel.Fields[0].AsString;
              qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
              qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 1000;
              qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MZI_CADCOL', VS_strCodEmp);
              qryCadCol.Post;
            End;
          end;

          Inc(intProgresso);
          pRegistraProgresso(0,intProgresso,Excel.RecordCount);
          Excel.Next;
        end;

        pDestruirVariaveis;

        FreeAndNil(qryCadCol);

      until FindNext(search_rec) <> 0;

      FindClose(search_rec);

    except
      Result := false;
    end;
  End
  else
    Result := false;

  if Result then
    pRegistraAcao('Cadastro de colorante realizado com sucesso!')
  else
    pRegistraAcao('Não foi possível realizar o cadastro de colorante!')

end;


function TMazaImobiliariaDinamica.fProcessaCadMzi: Boolean;
var
  qryMziCad      : TUniQuery;
  qryCadEmb      : TUniQuery;
  qryDelMzi      : TUniQuery;
  search_rec     : TSearchRec;
  strPathDirFile : String;
  intCont        : Integer;
  intIdx         : Integer;
  intProgresso   : Integer;
begin
  Result  := true;

  intCont := 0;
  intIdx  := 0;

  If FindFirst(strPat + '\*.xls', faAnyFile, search_rec) = 0 Then
  Begin
    try
      pRegistraAcao(' Cadastrando as Tintas...');

      repeat
        intProgresso := 0;

        strPathDirFile := (strPat + '\' + search_rec.Name);

        If (Not FileExists(strPathDirFile)) Then
        Begin
          fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPat, ['&Ok']);
          Exit;
        End;

        if (intIdx = 0) then
        begin
          qryDelMzi :=  fCriaQuery;
          qryDelMzi.SQL.Text := ' DELETE FROM MZI_CADMZI';
          qryDelMzi.ExecSQL;
        end;

        pRegistraAcao(' Processando o arquivo ' + search_rec.Name);

        pCarregarVariaveis(strPathDirFile);

        Excel.Close;
        Excel.CommandText := 'SELECT [Color Name]   AS COLNAM'+
                             '     , [Color Number] AS COLNUM'+
                             '     , [BASE]                  '+
                             '     , [Col1]                  '+
                             '     , [Oz1]                   '+
                             '     , [48ths1]                '+
                             '     , [Col2]                  '+
                             '     , [Oz2]                   '+
                             '     , [48ths2]                '+
                             '     , [Col3]                  '+
                             '     , [Oz3]                   '+
                             '     , [48ths3]                '+
                             '     , [Col4]                  '+
                             '     , [Oz4]                   '+
                             '     , [48ths4]                '+
            Format(' FROM [%s] ', [Planilhas.Strings[0]]) ;


        Excel.Open;

        qryMziCad := fCriaQuery;
        qryMziCad.SQL.Text := ' SELECT * FROM MZI_CADMZI WHERE FALSE';
        qryMziCad.Open;

        qryCadEmb := fCriaQuery;
        qryCadEmb.SQL.Text := ' SELECT DISTINCT EMB_UNIDAD AS UNID FROM MZI_CADEMB ';
        qryCadEmb.Open;

        Excel.First;

        While Not Excel.Eof Do
        Begin
          qryCadEmb.First;

          While not (qryCadEmb.eof) do
          begin

            Inc(intIdx);

            qryMziCad.Insert;
            qryMziCad.fieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MZI_CADMZI', VS_strCodEmp);
            qryMziCad.fieldByName('MZI_CODEMP').AsString := VS_strCodEmp;
            qryMziCad.fieldByName('MZI_CODMZI').AsInteger:= intIdx;
            qryMziCad.fieldByName('MZI_COLNUM').AsString := Excel.FieldByName('COLNUM').AsString;
            qryMziCad.fieldByName('MZI_COLNAM').AsString := Excel.FieldByName('COLNAM').AsString;
            qryMziCad.fieldByName('MZI_CODBAS').AsString := Excel.FieldByName('BASE').AsString;
            qryMziCad.fieldByName('MZI_PRODUT').AsString := Arr_Produtos[intCont];
            qryMziCad.fieldByName('MZI_CODUNI').AsString := qryCadEmb.FieldByName('UNID').AsString;
            qryMziCad.fieldByName('MZI_CODC01').AsString := Excel.FieldByName('Col1').AsString;
            qryMziCad.fieldByName('MZI_CODC02').AsString := Excel.FieldByName('Col2').AsString;
            qryMziCad.fieldByName('MZI_CODC03').AsString := Excel.FieldByName('Col3').AsString;
            qryMziCad.fieldByName('MZI_CODC04').AsString := Excel.FieldByName('Col4').AsString;

            qryMziCad.fieldByName('MZI_QTDC01').AsFloat  := fOncasParaMl(Excel.FieldByName('OZ1').AsString + 'Y' +
                                                            Excel.FieldByName('48ths1').AsString) * fRetornarFator(qryCadEmb.FieldByName('UNID').AsString);

            qryMziCad.fieldByName('MZI_QTDC02').AsFloat  := fOncasParaMl(Excel.FieldByName('OZ2').AsString + 'Y' +
                                                            Excel.FieldByName('48ths2').AsString)* fRetornarFator(qryCadEmb.FieldByName('UNID').AsString);

            qryMziCad.fieldByName('MZI_QTDC03').AsFloat  := fOncasParaMl(Excel.FieldByName('OZ3').AsString + 'Y' +
                                                            Excel.FieldByName('48ths3').AsString)* fRetornarFator(qryCadEmb.FieldByName('UNID').AsString);

            qryMziCad.fieldByName('MZI_QTDC04').AsFloat  := fOncasParaMl(Excel.FieldByName('OZ4').AsString + 'Y' +
                                                            Excel.FieldByName('48ths4').AsString)* fRetornarFator(qryCadEmb.FieldByName('UNID').AsString);

            qryMziCad.Post;

            qryCadEmb.Next;

          end;

          Inc(intProgresso);
          pRegistraProgresso(0,intProgresso,Excel.RecordCount);

          Excel.Next;

        end;

        pDestruirVariaveis;

      Inc(intCont);

      until FindNext(search_rec) <> 0;

      FindClose(search_rec);

    except
      Result  := false;
    end;
  End
  else
    Result  := false;

  if Result then
    pRegistraAcao('Cadastro de tintas realizado com sucesso!')
  else
    pRegistraAcao('Não foi possível realizar o cadastro de tintas!');

end;

function TMazaImobiliariaDinamica.fRetornarFator(StrEmbalagem : String): Double;
begin
  Result := 0;
  if StrEmbalagem = 'LT' then Result := 1;
  if StrEmbalagem = 'GL' then Result := 4;
  if StrEmbalagem = 'LA' then Result := 20;
end;

procedure TMazaImobiliariaDinamica.pCarregarVariaveis(strPathFile : String );
begin
  Conexao                  := TADOConnection.Create(nil);
  Conexao.LoginPrompt      := False;
  Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + strPathFile +  ' ;Extended Properties="Excel 8.0;Persist Security Info=False"';
  Conexao.Open;

  Excel := TADODataSet.Create(nil);
  Excel.Connection := Conexao;

  Planilhas := TStringList.Create;
  Conexao.GetTableNames(Planilhas);
end;

procedure TMazaImobiliariaDinamica.pDestruirVariaveis;
begin
  if Assigned(Conexao)   then FreeAndNil(Conexao);
  if Assigned(Excel)     then FreeAndNil(Excel);
  if Assigned(Planilhas) then FreeAndNil(Planilhas);
end;

procedure TMazaImobiliariaDinamica.SetOpcoes(const Value: TMazaImobiliariaOpcoes);
begin
  FOpcoes := Value;
end;

procedure pDeletaNovaFormulaDinamica(strCodPro: String);
Var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery;

    qryDel.SQL.Clear;
    qryDel.Close;
    qryDel.SQL.Text := 'DELETE FROM MZI_CADMZI '+
                       ' WHERE MZI_CODMZI = :CODPRO ';

    qryDel.ParamByName('CODPRO').AsString := strCodPro;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;
end;

{**************************************************}
{* NOVA REGRA PASSADA PELA MazaImobiliaria        *}
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

function fOncasParaMl(Oncas : String): Double;
  Var
    strInteira  : String;
    strFracao   : String;
    strOncas    : String;
begin
  strOncas := AnsiReplaceStr(Oncas,'.',',');
  strInteira := Copy(strOncas, 0, Pos('Y', strOncas) - 1);
  strFracao := Copy(strOncas, Pos('Y', strOncas) + 1, Length(strOncas));
  Result := fStrToFloat(FormatFloat('0.000000', fStrToFloat(strInteira) * 29.5735295625 + fStrToFloat(strFracao) * 0.61611520));
end;

end.
