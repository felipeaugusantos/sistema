unit OrdemProducaoIndustrial.TCadFaseFormulaEspecial;

interface

uses Windows, Classes, Controls, Forms, uni, System.SysUtils,
     untFuncoesSimples, untZClient, Data.DB;

  Type
    TCadFaseFormulaEspecial = Class

      private

        FCodigoEmpresa   : String;
        FCodigoFase      : String;
        FAutoIncremGeiMat: String;
        FCdsFaseEspecial : TZClient;
        FDtsFaseEspecial : TDataSource;
        FAutoIncrem      : String;
        FSequencialDaFase: String;
        FChaveDoCadastroDeFase: String;
        FPersisteNoBanco : Boolean;

      public

        constructor Create;
        destructor Destroy; Override;

        property strCodigoEmpresa: String read FCodigoEmpresa write FCodigoEmpresa;
        property strAutoIncremGeiMat: String read FAutoIncremGeiMat write FAutoIncremGeiMat;
        property cdsFaseEspecial: TZClient read FCdsFaseEspecial write FCdsFaseEspecial;
        property strAutoIncrem: String read FAutoIncrem write FAutoIncrem;
        property strSequencialDaFase: String read FSequencialDaFase write FSequencialDaFase;
        property strChaveDoCadastroDeFase: String read FChaveDoCadastroDeFase write FChaveDoCadastroDeFase;
        property strCodigoFase: String read FCodigoFase write FCodigoFase;
        property dtsFaseEspecial: TDataSource read FDtsFaseEspecial write FDtsFaseEspecial;
        property blnPersisteNoBanco: Boolean read FPersisteNoBanco write FPersisteNoBanco;

        procedure pDeletaFaseEspecial;
        procedure pCarregaFaseFormulaEspecial;
        procedure pGravarFormulaEspecial;

        function fRetornaAutIncCadFase: String;
        function fSQLFaseEspecial : String;
        function fRetDescricaoDaFase: String;
        function fRetCodigoDaFase: String;


  End;

implementation

constructor TCadFaseFormulaEspecial.Create;
Begin
  FCodigoEmpresa    := '';
  FCodigoFase       := '';
  FAutoIncremGeiMat := '';
  FAutoIncrem       := '';
  FSequencialDaFase := '';
  FChaveDoCadastroDeFase:= '';
  FPersisteNoBanco  := False;
  FCdsFaseEspecial  := Nil;

  FCdsFaseEspecial  := TZClient.Create(Nil, fSQLFaseEspecial);
  dtsFaseEspecial   := fCriaDataSource(FCdsFaseEspecial);

  FCdsFaseEspecial.IndexFieldNames:= 'GFA_SEQUEC';

End;

destructor TCadFaseFormulaEspecial.Destroy;
Begin
  FreeAndNil(FCdsFaseEspecial);
End;

Function TCadFaseFormulaEspecial.fSQLFaseEspecial : String;
Begin
  Result := '';
  Result := Result + ' SELECT GF.AUTOINCREM, GFA_SEQUEC, GFA_SEQGER, ';
  Result := Result + '        GFA_CODEMP, GFA_FASSEQ,                ';
  Result := Result + '        CAST(" " AS CHAR(80)) AS DESFAS,       ';
  Result := Result + '        CAST(" " AS CHAR(3)) AS CODFAS         ';
  Result := Result + ' FROM GEIFAS GF                                ';
  Result := Result + '    INNER JOIN CADFAS GC ON (GF.GFA_FASSEQ = GC.AUTOINCREM) ';
  Result := Result + '    WHERE GF.GFA_SEQGER = :SEQGER ';
End;

procedure TCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial;
begin
  FCdsFaseEspecial.qryQuery.Close;
  FCdsFaseEspecial.qryQuery.ParamByName('SEQGER').AsString := FAutoIncremGeiMat;
  FCdsFaseEspecial.fAbreClient(True, 'TCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial');

  If Not(FCdsFaseEspecial.IsEmpty) Then
  Begin
    FCdsFaseEspecial.First;
    While Not FCdsFaseEspecial.eof do
    Begin
      FCdsFaseEspecial.Edit;
      FChaveDoCadastroDeFase:= FCdsFaseEspecial.FieldByName('GFA_FASSEQ').AsString;
      FCodigoFase           := fRetCodigoDaFase;

      FCdsFaseEspecial.FieldByName('CODFAS').AsString     := fRetCodigoDaFase;
      FCdsFaseEspecial.FieldByName('DESFAS').AsString     := fRetDescricaoDaFase;
      FCdsFaseEspecial.Post;

      FChaveDoCadastroDeFase:= '';
      FCodigoFase:= '';

      FCdsFaseEspecial.Next;

    End;
  End;


end;

procedure TCadFaseFormulaEspecial.pDeletaFaseEspecial;
var
  qryGenerico: TUniQuery;
begin
  qryGenerico := fCriaQuery(Nil);
  Try
    If FPersisteNoBanco Then
    Begin
      qryGenerico.Close;
      qryGenerico.SQL.Clear;
      qryGenerico.SQL.Add('DELETE FROM GEIFAS WHERE GFA_SEQGER = :SEQGER');
      qryGenerico.ParamByName('SEQGER').AsString := FAutoIncremGeiMat;
      qryGenerico.ExecSQL;
    End
    Else
      FCdsFaseEspecial.Delete;

  Finally
    FreeAndNil(qryGenerico);
  End;

end;


procedure TCadFaseFormulaEspecial.pGravarFormulaEspecial;
var
  qryGenerico: TUniQuery;
begin
  If FPersisteNoBanco Then
  Begin

    qryGenerico := fCriaQuery(Nil);
    Try

      FCdsFaseEspecial.First;
      While Not FCdsFaseEspecial.eof do
      Begin
        qryGenerico.Close;
        qryGenerico.SQL.Clear;
        qryGenerico.SQL.Add('INSERT INTO GEIFAS(AUTOINCREM, GFA_SEQUEC, GFA_SEQGER, GFA_FASSEQ, GFA_CODEMP)');
        qryGenerico.SQL.Add('VALUES(:AUTINC, :SEQUEC, :SEQGER, :FASSEQ, :CODEMP)');
        qryGenerico.ParamByName('AUTINC').AsString:= FCdsFaseEspecial.FieldByName('AUTOINCREM').AsString;
        qryGenerico.ParamByName('SEQUEC').AsString:= FCdsFaseEspecial.FieldByName('GFA_SEQUEC').AsString;
        qryGenerico.ParamByName('SEQGER').AsString:= FAutoIncremGeiMat;
        qryGenerico.ParamByName('FASSEQ').AsString:= FCdsFaseEspecial.FieldByName('GFA_FASSEQ').AsString;
        qryGenerico.ParamByName('CODEMP').AsString:= FCdsFaseEspecial.FieldByName('GFA_CODEMP').AsString;
        qryGenerico.ExecSQL;

        FCdsFaseEspecial.Next;
      End;

    Finally
      FreeAndNil(qryGenerico);
    End;

  End
  Else
  Begin

    If (FCdsFaseEspecial.Locate('GFA_SEQUEC', FSequencialDaFase, [])) Then
    Begin
      fMensagem('AVISO', 'Já existe um registro com a sequência informada !', ['&Ok']);
      Exit;
    End;

    If Not(FCdsFaseEspecial.Locate('GFA_FASSEQ', FChaveDoCadastroDeFase, [])) Then
      FCdsFaseEspecial.Insert
    Else
      FCdsFaseEspecial.Edit;

    FCdsFaseEspecial.FieldByName('AUTOINCREM').AsString := FAutoIncrem;
    FCdsFaseEspecial.FieldByName('GFA_SEQUEC').AsString := FSequencialDaFase;
    FCdsFaseEspecial.FieldByName('GFA_CODEMP').AsString := FCodigoEmpresa;
    FCdsFaseEspecial.FieldByName('GFA_SEQGER').AsString := FAutoIncremGeiMat;
    FCdsFaseEspecial.FieldByName('GFA_FASSEQ').AsString := FChaveDoCadastroDeFase;
    FCdsFaseEspecial.FieldByName('CODFAS').AsString     := strCodigoFase;
    FCdsFaseEspecial.FieldByName('DESFAS').AsString     := fRetDescricaoDaFase;
    FCdsFaseEspecial.Post;
  End;

end;

function TCadFaseFormulaEspecial.fRetornaAutIncCadFase: String;
var
  qryCons: TUniQuery;
Begin
  qryCons:= fCriaQuery;
  Try
    qryCons.SQL.Add('SELECT AUTOINCREM FROM CADFAS '+
                    '  WHERE FAS_CODFAS = :CODFAS  ');

    qryCons.ParamByName('CODFAS').AsString:= FCodigoFase;

    qryCons.Open;

    result:= qryCons.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryCons);
  End;

End;

function TCadFaseFormulaEspecial.fRetDescricaoDaFase: String;
var
  qryCons: TUniQuery;
Begin
  qryCons:= fCriaQuery;
  Try
    qryCons.SQL.Add('SELECT FAS_DESFAS FROM CADFAS '+
                    '  WHERE FAS_CODFAS = :CODFAS  ');

    qryCons.ParamByName('CODFAS').AsString:= FCodigoFase;

    qryCons.Open;

    result:= qryCons.FieldByName('FAS_DESFAS').AsString;

  Finally
    FreeAndNil(qryCons);
  End;

End;

function TCadFaseFormulaEspecial.fRetCodigoDaFase: String;
var
  qryCons: TUniQuery;
Begin
  qryCons:= fCriaQuery;
  Try
    qryCons.SQL.Add('SELECT FAS_CODFAS FROM CADFAS '+
                    '  WHERE AUTOINCREM = :AUTINC  ');

    qryCons.ParamByName('AUTINC').AsString:= FChaveDoCadastroDeFase;

    qryCons.Open;

    result:= qryCons.FieldByName('FAS_CODFAS').AsString;

  Finally
    FreeAndNil(qryCons);
  End;

End;




end.
