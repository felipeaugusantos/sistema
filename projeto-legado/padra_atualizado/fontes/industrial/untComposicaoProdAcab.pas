unit untComposicaoProdAcab;

interface
uses

  SysUtils, Classes, DB,   Uni, StrUtils, Variants;


function fGravaGerCom(Var strAutInc: String;
                      strCodEmp,
                      strCodCom,
                      strDesCom:String): Boolean;

function fGravaDetCom(strSeqGer,
                      strSeQuen,
                      strCodEmp,
                      strCodIte: String;
                      fltQtdIte: Double;
                      strDescri,
                      strRefere,
                      strUnidad,
                      strImp_Op: String): Boolean;

implementation

uses untfuncoesSimples;

function fGravaGerCom(var strAutInc: String;
                      strCodEmp,
                      strCodCom,
                      strDesCom: String): Boolean;
  Var
    qryGerCpa: TUniQuery;
    strCodNov: String;
begin
  Result := True;
  Try
    Try

      qryGerCpa := fCriarQuery('SELECT * FROM GERCOM WHERE FALSE', nil);
      With qryGerCpa Do
      Begin

        If Not Active Then
          Open;

        Insert;

        If (fEmptyStr(strCodCom)) Then
        Begin
          strCodNov := fAtualizaProCod('GERCOM', 'GCO_CODCOM', '', 1, Nil,
            function (const AValue: String) : String
            begin
              Result := fPadL(AValue, 5, '0');
            end
          );
        End
        Else
          strCodNov := strCodCom;

        strAutInc := fRetAutoIncrem('GERCOM',strCodEmp);
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('GCO_CODCOM').AsString := strCodNov;
        FieldByName('GCO_CODEMP').AsString := strCodEmp;
        FieldByName('GCO_DESCOM').AsString := strDesCom;

        Post;
      End;

    Except
      On E: Exception Do
      Begin
        qryGerCpa.Cancel;
        Result := False;
        Raise Exception.Create(e.Message);
      End;
    End;
  Finally
    FreeAndNil(qryGerCpa);
  End;
end;

function fGravaDetCom(strSeqGer,
                      strSeQuen,
                      strCodEmp,
                      strCodIte: String;
                      fltQtdIte: Double;
                      strDescri,
                      strRefere,
                      strUnidad,
                      strImp_Op: String): Boolean;
  Var
    strAutInc: String;
    qryDetCpa: TUniQuery;
begin

  Result := True;

  Try
    Try

      strAutInc := fRetAutoIncrem('DETCOM',strCodEmp);

      qryDetCpa := fCriarQuery('SELECT * FROM DETCOM WHERE FALSE', nil);
      With qryDetCpa Do
      Begin

        If Not Active Then
          Open;

        Insert;
        FieldByName('AUTOINCREM').AsString  := strAutInc;
        FieldByName('DCO_SEQGER').AsString  := strSeqGer;
        FieldByName('DCO_SEQUEN').AsString  := strSeQuen;
        FieldByName('DCO_CODEMP').AsString  := strCodEmp;
        FieldByName('DCO_CODITE').AsString  := strCodIte;
        FieldByName('DCO_QTDITE').AsFloat   := fltQtdIte;
        FieldByName('DCO_DESCRI').AsString  := strDescri;
        FieldByName('DCO_REFERE').AsString  := strRefere;
        FieldByName('DCO_UNIDAD').AsString  := strUnidad;
        FieldByName('DCO_IMP_OP').AsString  := strImp_Op;
        Post;

      End;

    Except
      On E: Exception Do
      Begin
        qryDetCpa.Cancel;
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryDetCpa);
  End;
end;

end.
