unit untEnviarXMLSat;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Forms,
  Windows,
{$ENDIF}
  Variants,
  SysUtils,
  Classes,
  StrUtils,
  DateUtils,
  DB,
  untConfigNFE,
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ,untRegistrarTarefa;

  type
    TEnviarXMLSat = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa: TRegistrarTarefa;
    function fEnviarXMLSat: Boolean;
  public
    constructor Create(ATarefa: TRegistrarTarefa);
    procedure Executar;
  end;

implementation

{ TEnviarXMLSat }

uses untInterfaces, untLibNfe, untDicSis;

constructor TEnviarXMLSat.Create(ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  Banco := frmModulo.Database;
end;

procedure TEnviarXMLSat.Executar;
Const
  cnsTagFechaEnvi = '</CFe>';
  cnsTagFechaCanc = '</CFeCanc>';

Var
  qrySATsPendentes: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryUpdate: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: String;
  strXML: String;
  strTagFecha: String;
  strValCfgMDEVAR: String;
  retornoNFE: TRetornoNFE;
  EnviarArquivos: IEnviarArquivosService;
  dtaDtaSis : TDateTime;
  dtaHraSis : TDateTime;
  objConfigSovos: TConfiguracoesNFE;
begin
  If Not fEnviarXMLSat Then
    Exit;

  Try
    Try
      qrySATsPendentes := fCriaQuery(Nil, Banco);
      qryUpdate := fCriaQuery(Nil, Banco);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  XMLSAT ';
      strSQL := strSQL + 'INNER JOIN CADFIS ';
      strSQL := strSQL + '  ON AUTOINCREM = XML_SEQFIS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  XML_ENVIAD = 0 AND ';
      strSQL := strSQL + '  FIS_CODEMP = :CODEMP ';
      strSQL := strSQL + 'ORDER BY XML_SEQFIS ';
      strSQL := strSQL + 'LIMIT 100 ' ;

      qrySATsPendentes.SQL.Add(strSQL);
      qrySATsPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qrySATsPendentes.Open;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  XMLSAT ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  XML_ENVIAD = :ENVIAD, ';
      strSQL := strSQL + '  XML_DTAENV = :DTAENV, ';
      strSQL := strSQL + '  XML_HORENV = :HORENV, ';
      strSQL := strSQL + '  XML_MSGRET = :MSGRET  ';
      strSQL := strSQL + 'WHERE XML_SEQFIS = :SEQFIS ';
      strSQL := strSQL + '  AND XML_TIPARQ = :TIPARQ ';

      qryUpdate.SQL.Add(strSQL);
      qrySATsPendentes.First;

      If (Not qrySATsPendentes.IsEmpty) Then
      Begin
        objConfigSovos := TConfiguracoesNFE.Create;
        objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
        objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
        objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
        objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');
        strValCfgMDEVAR := '';
        If fExisteConfiguracao('MDEVAR') Then
          strValCfgMDEVAR := fCfgSisPainel('MDEVAR');

        EnviarArquivos := fCriarEnviarArquivosServiceConfigurado(objConfigSovos);
      End;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

      While Not qrySATsPendentes.Eof Do
      Begin
        FTarefa.pSinalizarExecutando;

        If FTarefa.blnBloquear Then
          Break;

        FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(qrySATsPendentes.FieldByName('FIS_NUMDOC').AsString, '-',
                                                                       qrySATsPendentes.FieldByName('FIS_ESPDOC').AsString, '-',
                                                                       qrySATsPendentes.FieldByName('FIS_CODEMP').AsString));

        strTagFecha := cnsTagFechaEnvi;
        strXML := qrySATsPendentes.FieldByName('XML_ARQXML').AsString;
        If (Pos(AnsiLowerCase(cnsTagFechaCanc), AnsiLowerCase(strXML)) > 0) Then
          strTagFecha := cnsTagFechaCanc;

        strXML := AnsiReplaceStr(strXML, '<<csq>>', '');
        strXML := AnsiReplaceStr(strXML, strTagFecha, '');
        strXML := strXML + '<protFITNFe><ID_EXTERNO>' + qrySATsPendentes.FieldByName('FIS_NUMDOC').AsString + '</ID_EXTERNO></protFITNFe>';
        strXML := strXML + strTagFecha;

        If (fEmptyStr(strValCfgMDEVAR)) Then
        Begin
          retornoNFE := EnviarArquivos.fEnviarXMLSat(strXML);
        End
        Else
        Begin
          Try
            retornoNFE := EnviarArquivos.fEnviarXMLSatWithModeSoap(strXML, strValCfgMDEVAR);
          Except
            retornoNFE := EnviarArquivos.fEnviarXMLSat(strXML);
          End;
        End;

        If retornoNFE.Sucesso Then
        Begin
          pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);
          qryUpdate.ParamByName('ENVIAD').AsInteger := 1;
          qryUpdate.ParamByName('DTAENV').AsDate    := dtaDtaSis;
          qryUpdate.ParamByName('HORENV').AsTime    := dtaHraSis;
          qryUpdate.ParamByName('MSGRET').AsString  := LeftStr(retornoNFE.Mensagem, 150);
          qryUpdate.ParamByName('SEQFIS').AsString  := qrySATsPendentes.FieldByName('XML_SEQFIS').AsString;
          qryUpdate.ParamByName('TIPARQ').AsInteger := qrySATsPendentes.FieldByName('XML_TIPARQ').AsInteger;
        End
        Else
        Begin
          qryUpdate.ParamByName('ENVIAD').AsInteger := 0;
          qryUpdate.ParamByName('DTAENV').Value     := Null;
          qryUpdate.ParamByName('HORENV').Value     := Null;
          qryUpdate.ParamByName('MSGRET').AsString  := LeftStr(retornoNFE.Mensagem, 150);
          qryUpdate.ParamByName('SEQFIS').AsString  := qrySATsPendentes.FieldByName('XML_SEQFIS').AsString;
          qryUpdate.ParamByName('TIPARQ').AsInteger := qrySATsPendentes.FieldByName('XML_TIPARQ').AsInteger;
        End;

        qryUpdate.ExecSQL;

        qrySATsPendentes.Next;

        If Assigned(retornoNFE) Then
          FreeAndNil(retornoNFE);
      End;
    Except
      On E: Exception Do
        pLogarErro(FTarefa.strTarefa, E);
    End;
  Finally
    If Assigned(qrySATsPendentes) Then
      FreeAndNil(qrySATsPendentes);

    If Assigned(qryUpdate) Then
      FreeAndNil(qryUpdate);

    If Assigned(objConfigSovos) Then
      FreeAndNil(objConfigSovos);
  End;
end;

function TEnviarXMLSat.fEnviarXMLSat: Boolean;
begin
  Try
    Result := False;
    If fTabelaExiste('XMLSAT', Banco) And
       fCampoExiste('XMLSAT', 'XML_ENVIAD', Banco) And
       fCampoExiste('XMLSAT', 'XML_DTAENV', Banco) And
       fCampoExiste('XMLSAT', 'XML_HORENV', Banco) And
       fCampoExiste('XMLSAT', 'XML_MSGRET', Banco) Then
    Begin
      If fCampoTabela('COUNT(*)', 'XMLSAT INNER JOIN CADFIS ON AUTOINCREM = XML_SEQFIS',
        ['XML_ENVIAD', 'FIS_CODEMP'], [0, VS_strCodEmp], Banco) > 0 Then
      Begin
        Result := True;
      End;
    End;
  Except
    Result := False;
  End;
end;

end.
