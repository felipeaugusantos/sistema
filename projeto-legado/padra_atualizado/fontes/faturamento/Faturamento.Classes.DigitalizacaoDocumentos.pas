unit Faturamento.Classes.DigitalizacaoDocumentos;

interface

uses
  Data.DB;

type
  TDadosDigitalizacaoDocumentos = record
    strAutInc: String;
    strSeqGer: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strNomEmp: String;
    strCodCli: String;
    strNomCli: String;
    strArquivo: String;
    dtaDtaEnt: TDateTime;
  end;

  TDigitalizacaoDocumentos = class
  public
    class function fGravar(var ADados: TDadosDigitalizacaoDocumentos): Boolean;
    class function fExcluir(const strAutInc: String): Boolean;

    class function fDocDigitalizado(const strAutIncDoc: String): Boolean;

    class procedure pGravaTmp(const ADataSet: TDataSet;
      const ADados: TDadosDigitalizacaoDocumentos);
    class function fDocumentoExiste(const ADados: TDadosDigitalizacaoDocumentos;
      var strAutInc, strCodCli: string; var dtaDtaEnt: TDateTime): Boolean; static;

    class procedure pMostrarImagem(const strBase64: String);
  end;

implementation

uses
  System.SysUtils, Vcl.Graphics, Uni, untFuncoesSimples, untImagemBase64, untImagem ;

{ TDigitalizacaoDocumentos }

class function TDigitalizacaoDocumentos.fDocDigitalizado(
  const strAutIncDoc: String): Boolean;
var
  LqryConsulta: TUniQuery;
begin
  LqryConsulta := fCriaQuery();
  try
    LqryConsulta.SQL.Add('SELECT AUTOINCREM FROM MOVDIG WHERE DIG_SEQGER = :SEQGER');
    LqryConsulta.ParamByName('SEQGER').AsString := strAutIncDoc;
    LqryConsulta.Open;

    Result := not LqryConsulta.IsEmpty;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

class function TDigitalizacaoDocumentos.fDocumentoExiste(
  const ADados: TDadosDigitalizacaoDocumentos; var strAutInc,
  strCodCli: string; var dtaDtaEnt: TDateTime): Boolean;
var
  LqryConsulta: TUniQuery;
begin
  strAutInc := '';
  strCodCli := '';

  LqryConsulta := fCriaQuery;
  try
    LqryConsulta.SQL.Add('SELECT AUTOINCREM, GER_CODCLI, GER_DTAENT');
    LqryConsulta.SQL.Add('  FROM MOVGER');
    LqryConsulta.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    LqryConsulta.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    LqryConsulta.SQL.Add('   AND GER_CODEMP = :CODEMP');
    if not fEmptyStr(ADados.strCodCli) then
      LqryConsulta.SQL.Add('   AND GER_CODCLI = :CODCLI');

    LqryConsulta.ParamByName('NUMDOC').AsString := ADados.strNumDoc;
    LqryConsulta.ParamByName('ESPDOC').AsString := ADados.strEspDoc;
    LqryConsulta.ParamByName('CODEMP').AsString := ADados.strCodEmp;
    if not fEmptyStr(ADados.strCodCli) then
      LqryConsulta.ParamByName('CODCLI').AsString := ADados.strCodCli;

    LqryConsulta.Open;
    Result := Not LqryConsulta.IsEmpty;

    if Result then
    begin
      strAutInc := LqryConsulta.FieldByName('AUTOINCREM').AsString;
      dtaDtaEnt := LqryConsulta.FieldByName('GER_DTAENT').AsDateTime;

      if fEmptyStr(ADados.strCodCli) then
        strCodCli := LqryConsulta.FieldByName('GER_CODCLI').AsString;
    end;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

class function TDigitalizacaoDocumentos.fExcluir(
  const strAutInc: String): Boolean;
var
  LqryConsulta: TUniQuery;
begin
  LqryConsulta := fCriaQuery();
  try
    LqryConsulta.SQL.Add('DELETE FROM MOVDIG WHERE AUTOINCREM = :AUTINC');
    LqryConsulta.ParamByName('AUTINC').AsString := strAutInc;
    LqryConsulta.ExecSQL;

    Result := LqryConsulta.RowsAffected = 1;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;

class function TDigitalizacaoDocumentos.fGravar(var
  ADados: TDadosDigitalizacaoDocumentos): Boolean;
var
  LqryConsulta: TUniQuery;
begin
  LqryConsulta := fCriaQuery();
  try
    LqryConsulta.SQL.Add('SELECT * FROM MOVDIG WHERE FALSE');
    LqryConsulta.Open;

    ADados.strAutInc := fRetAutoIncrem('MOVDIG', VS_strCodEmp);

    LqryConsulta.Insert;
    LqryConsulta.FieldByName('AUTOINCREM').AsString   := ADados.strAutInc;
    LqryConsulta.FieldByName('DIG_SEQGER').AsString   := ADados.strSeqGer;
    LqryConsulta.FieldByName('DIG_DTADOC').AsDateTime := ADados.dtaDtaEnt;
    LqryConsulta.FieldByName('DIG_NUMDOC').AsString   := ADados.strNumDoc;
    LqryConsulta.FieldByName('DIG_ESPDOC').AsString   := ADados.strEspDoc;
    LqryConsulta.FieldByName('DIG_EMPDOC').AsString   := ADados.strCodEmp;
    LqryConsulta.FieldByName('DIG_CODCLI').AsString   := ADados.strCodCli;
    LqryConsulta.FieldByName('DIG_NOMARQ').AsString   := ExtractFileName(ADados.strArquivo);
    LqryConsulta.FieldByName('DIG_IMGB64').AsString   := fBase64FromFile(ADados.strArquivo);
    LqryConsulta.FieldByName('DIG_DTADIG').AsDateTime := fNow;
    LqryConsulta.Post;

    Result := LqryConsulta.RowsAffected = 1;
  finally
    FreeAndNil(LqryConsulta);
  end;
end;


class procedure TDigitalizacaoDocumentos.pGravaTmp(const ADataSet: TDataSet;
  const ADados: TDadosDigitalizacaoDocumentos);
begin
  ADataSet.Edit;
  ADataSet.FieldByName('AUTOINCREM').AsString   := ADados.strAutInc;
  ADataSet.FieldByName('DIG_SEQGER').AsString   := ADados.strSeqGer;
  ADataSet.FieldByName('DIG_DTADOC').AsDateTime := ADados.dtaDtaEnt;
  ADataSet.FieldByName('DIG_NUMDOC').AsString   := ADados.strNumDoc;
  ADataSet.FieldByName('DIG_ESPDOC').AsString   := ADados.strEspDoc;
  ADataSet.FieldByName('DIG_EMPDOC').AsString   := ADados.strCodEmp;
  ADataSet.FieldByName('NOMEMP').AsString       := ADados.strNomEmp;
  ADataSet.FieldByName('DIG_CODCLI').AsString   := ADados.strCodCli;
  ADataSet.FieldByName('NOMCLI').AsString       := ADados.strNomCli;
  ADataSet.FieldByName('DIG_NOMARQ').AsString   := ExtractFileName(ADados.strArquivo);
  ADataSet.FieldByName('DIG_IMGB64').AsString   := fBase64FromFile(ADados.strArquivo);
  ADataSet.FieldByName('DIG_DTADIG').AsDateTime := fNow;
  ADataSet.Post;
end;

class procedure TDigitalizacaoDocumentos.pMostrarImagem(
  const strBase64: String);
var
  frmImagem: TfrmImagem;
  LPict: TPicture;
begin
  pCriarFormularios(TfrmImagem, frmImagem);
  try
    frmImagem.imgFoto.Visible := True;

    LPict := TPicture.Create();
    try
      pImagemFromBase64(strBase64, LPict);
      frmImagem.imgFoto.Picture.Assign(LPict);
    finally
      FreeAndNil(LPict);
    end;

    frmImagem.btnTamFig.Visible := True;
    frmImagem.lbl1.Visible := True;
    frmImagem.Caption := 'Foto';
    frmImagem.ShowModal;
  finally
    pFreeAndNil(frmImagem);
  end;
end;


end.
