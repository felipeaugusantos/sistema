unit untTFaturamentoMercadoLivre;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncFat,
{$ENDIF}
  StrUtils, DateUtils, SysUtils, Classes, Data.DB, Uni,
  Faturamento.Classes.TFatVendaBase, Fulfillment.Funcoes;

type
  TFaturamentoMercadoLivre = class sealed
  private
    const MercadoLivrePrefix = 'MLB';
  private
    class procedure AtualizaTabMov(const ATabela, APrefixo: String; const ADatEnt: TDate; const AHorEnt: TTime; var AqryCadFis: TUniQuery);
    class procedure AtualizaCadRec(const ADatEnt: TDate; var AqryCadFis: TUniQuery);
    class procedure AtualizaMovCar(const ANumPok: String; const ADatEnt: TDate; var AqryCadFis: TUniQuery);
  public
    class function UtilizaFaturadorMercadoLivre(): Boolean;
    class function ImportarSomenteNotasFaturadorMLB(): Boolean;
    class function NFeEmitidaPeloFaturador(AChaveAcesso, AOrderID: String): Boolean;
    class function NFeAutorizadaFaturador(AChaveAcesso: String): Boolean;
    class function NFeSeraEmitidaPeloFaturador(AObjVenda: TFatVenda): Boolean;
    class function AtualizarDadosNFe(AObjVenda: TFatVenda): Boolean;
    class function AtualizarDocumentoFinanceiro(AObjVenda: TFatVenda): Boolean;
    class function FaturarDocumentoTransitorio(AObjVenda: TFatVenda): Boolean;
    class function DeletarDocumentoTransitorio(AObjVenda: TFatVenda): Boolean;
    class function AlterarFaturamentoPedidoDeVenda(AObjVenda: TFatVenda): Boolean;
    class function RetornaClienteFaturamento(AChaveAcesso: String): String;
    class function ValidarTotalNFe(AObjVenda: TFatVenda): Boolean;
    class function ValidarClienteNFe(AObjVenda: TFatVenda): Boolean;
    class function ValidarProdutosNFe(AObjVenda: TFatVenda): Boolean;
    class function NotaEmitidaAnteriormenteEmContingencia(const ANumDoc, AEspDoc, ACodEmp, ASerie, AChave: String; out strChaveCtg: String): Boolean;
    class function AtualizaInformacoesContingencia(const AChaveCtg, AChave, ANumPok: String; const ADtaEnt: TDate; const AHorEnt: TTime; out strMensagem: String): Boolean;
  end;

implementation

uses
{$IFDEF LINUX}

{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untFuncoesGenerica,
  untFuncFatTypes, Shared.Functions.DataSet;

{ TFaturamentoMercadoLivre }

class function TFaturamentoMercadoLivre.AlterarFaturamentoPedidoDeVenda(AObjVenda: TFatVenda): Boolean;
Var
  LFatMLB: IMyCampoTabela;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  LFatMLB   := fCampoTabela(['*'], 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);

  Result := fExecutaSQL(
    ' UPDATE FATGOR ' +
    ' SET FGO_NUMFAT = "' + AObjVenda.strNumDoc + '", ' +
    '     FGO_TIPFAT = "' + AObjVenda.strEspDoc + '", ' +
    '     FGO_EMPFAT = "' + AObjVenda.strEmpDoc + '", ' +
    '     FGO_VENFAT = "' + AObjVenda.strCodVen + '", ' +
    '     FGO_CNDFAT = "' + AObjVenda.strConPag + '", ' +
    '     FGO_VALFAT = "' + FloatToStr(AObjVenda.fltTotGer).Replace(',', '.') + '", ' +
    '     FGO_DTAFAT = "' + FormatDateTime('yyyy-MM-dd', AObjVenda.dtaDtaEnt) + '" ' +
    ' WHERE ' +
    '   FGO_NUMFAT = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" AND ' +
    '   FGO_TIPFAT = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" AND ' +
    '   FGO_EMPFAT = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" AND ' +
    '   FGO_CODCLI = "' + LFatMLB.FieldByName('MLB_CODCLI').AsString + '" AND ' +
    '   FGO_JAFATU = 1 ' );

  Result := Result And fExecutaSQL(
    ' UPDATE FATDOR ' +
    ' SET FDO_NUMFAT = "' + AObjVenda.strNumDoc + '", ' +
    '     FDO_TIPFAT = "' + AObjVenda.strEspDoc + '", ' +
    '     FDO_EMPFAT = "' + AObjVenda.strEmpDoc + '", ' +
    '     FDO_VENFAT = "' + AObjVenda.strCodVen + '", ' +
    '     FDO_CNDFAT = "' + AObjVenda.strConPag + '", ' +
    '     FDO_DTAFAT = "' + FormatDateTime('yyyy-MM-dd', AObjVenda.dtaDtaEnt) + '" ' +
    ' WHERE ' +
    '   FDO_NUMFAT = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" AND ' +
    '   FDO_TIPFAT = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" AND ' +
    '   FDO_EMPFAT = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" AND ' +
    '   FDO_CODCLI = "' + LFatMLB.FieldByName('MLB_CODCLI').AsString + '" AND ' +
    '   FDO_JAFATU = 1 ' );
end;

class procedure TFaturamentoMercadoLivre.AtualizaCadRec(const ADatEnt: TDate;
  var AqryCadFis: TUniQuery);
  Var
    LqryUpdate: TUniQuery;
begin
  LqryUpdate := fCriaQuery;
  Try
    LqryUpdate.SQL.Add('UPDATE CADREC');
    LqryUpdate.SQL.Add('  SET CTR_DTACAD = :DTACAD');
    LqryUpdate.SQL.Add('     ,CTR_DTAVEN = :DTAVEN');
    LqryUpdate.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP');
    LqryUpdate.SQL.Add('  AND CTR_ESPDOC = :ESPDOC');
    LqryUpdate.SQL.Add('  AND CTR_CODEMP = :CODEMP');
    LqryUpdate.SQL.Add('  AND CTR_CODCLI = :CODCLI');

    LqryUpdate.ParamByName('DTACAD').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('DTAVEN').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('NUMDUP').AsString   := AqryCadFis.FieldByName('FIS_NUMDOC').AsString;
    LqryUpdate.ParamByName('ESPDOC').AsString   := AqryCadFis.FieldByName('FIS_ESPDOC').AsString;
    LqryUpdate.ParamByName('CODEMP').AsString   := AqryCadFis.FieldByName('FIS_CODEMP').AsString;
    LqryUpdate.ParamByName('CODCLI').AsString   := AqryCadFis.FieldByName('FIS_FORCLI').AsString;
    LqryUpdate.ExecSQL;
  Finally
    FreeAndNil(LqryUpdate);
  End;
end;

class procedure TFaturamentoMercadoLivre.AtualizaMovCar(const ANumPok: String;
  const ADatEnt: TDate; var AqryCadFis: TUniQuery);
  Var
    LqryUpdate: TUniQuery;
begin
  LqryUpdate := fCriaQuery;
  Try
    LqryUpdate.SQL.Add('UPDATE MOVCAR');
    LqryUpdate.SQL.Add('  SET MCA_DTACAD = :DTACAD');
    LqryUpdate.SQL.Add('     ,MCA_DTAVEN = :DTAVEN');
    LqryUpdate.SQL.Add('WHERE MCA_CODEMP = :CODEMP');
    LqryUpdate.SQL.Add('  AND MCA_CODCLI = :CODCLI');
    LqryUpdate.SQL.Add('  AND (MCA_DOCUME LIKE :DOCUME');
    If Not fEmptyStr(ANumPok) Then
      LqryUpdate.SQL.Add('   OR MCA_NUMPOK = :NUMPOK');
    LqryUpdate.SQL.Add(')');

    LqryUpdate.ParamByName('DTACAD').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('DTAVEN').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('CODEMP').AsString   := AqryCadFis.FieldByName('FIS_CODEMP').AsString;
    LqryUpdate.ParamByName('CODCLI').AsString   := AqryCadFis.FieldByName('FIS_FORCLI').AsString;
    LqryUpdate.ParamByName('DOCUME').AsString   := Concat(AqryCadFis.FieldByName('FIS_NUMDOC').AsString, '-_-',
                                                          AqryCadFis.FieldByName('FIS_ESPDOC').AsString, '-',
                                                          AqryCadFis.FieldByName('FIS_CODEMP').AsString, '%');
    If Not fEmptyStr(ANumPok) Then
      LqryUpdate.ParamByName('NUMPOK').AsString   := ANumPok;
    LqryUpdate.ExecSQL;
  Finally
    FreeAndNil(LqryUpdate);
  End;
end;

class procedure TFaturamentoMercadoLivre.AtualizaTabMov(const ATabela, APrefixo: String;
  const ADatEnt: TDate; const AHorEnt: TTime; var AqryCadFis: TUniQuery);
  Var
    LqryUpdate: TUniQuery;
begin
  LqryUpdate := fCriaQuery;
  Try
    LqryUpdate.SQL.Add('UPDATE ' + ATabela); //MOVGER/MOVDET/NOTGER/NOTDET
    LqryUpdate.SQL.Add('  SET ' + APrefixo + 'DTAENT = :DTAENT');
    LqryUpdate.SQL.Add('     ,' + APrefixo + 'HORENT = :HORENT');
    If ATabela.Contains('MOV') Then
      LqryUpdate.SQL.Add('     ,' + APrefixo + 'DTADOC = :DTADOC');
    LqryUpdate.SQL.Add('WHERE ' + APrefixo + 'NUMDOC = :NUMDOC');
    LqryUpdate.SQL.Add('  AND ' + APrefixo + 'ESPDOC = :ESPDOC');
    LqryUpdate.SQL.Add('  AND ' + APrefixo + 'CODEMP = :CODEMP');
    LqryUpdate.SQL.Add('  AND ' + APrefixo + 'SERIE_ = :SERIE_');
    LqryUpdate.SQL.Add('  AND ' + APrefixo + 'TIP_FC = :TIP_FC');
    LqryUpdate.SQL.Add('  AND IF(' + APrefixo + 'TIP_FC = "C",' + APrefixo + 'CODCLI,' + APrefixo + 'CODFOR) = :FORCLI');

    LqryUpdate.ParamByName('DTAENT').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('HORENT').AsDateTime := AHorEnt;
    If ATabela.Contains('MOV') Then
      LqryUpdate.ParamByName('DTADOC').AsDateTime := ADatEnt;
    LqryUpdate.ParamByName('NUMDOC').AsString   := AqryCadFis.FieldByName('FIS_NUMDOC').AsString;
    LqryUpdate.ParamByName('ESPDOC').AsString   := AqryCadFis.FieldByName('FIS_ESPDOC').AsString;
    LqryUpdate.ParamByName('CODEMP').AsString   := AqryCadFis.FieldByName('FIS_CODEMP').AsString;
    LqryUpdate.ParamByName('SERIE_').AsString   := AqryCadFis.FieldByName('FIS_SERIE_').AsString;
    LqryUpdate.ParamByName('TIP_FC').AsString   := AqryCadFis.FieldByName('FIS_TIP_FC').AsString;
    LqryUpdate.ParamByName('FORCLI').AsString   := AqryCadFis.FieldByName('FIS_FORCLI').AsString;
    LqryUpdate.ExecSQL;
  Finally
    FreeAndNil(LqryUpdate);
  End;
end;

class function TFaturamentoMercadoLivre.AtualizaInformacoesContingencia(
  const AChaveCtg, AChave, ANumPok: String; const ADtaEnt: TDate;
  const AHorEnt: TTime; out strMensagem: String): Boolean;
  Var
    LqryCadFis, LqryMovGer: TUniQuery;
    LHistorico: TStringList;
begin
  LHistorico := TStringList.Create;
  LqryCadFis := fCriaQuery;
  LqryMovGer := fCriaQuery;
  Try
    Try
      strMensagem := '';

      LqryCadFis.SQL.Add('SELECT * FROM CADFIS WHERE FIS_ACESSO = :ACESSO AND FIS_TIP_FC = "C"');
      LqryCadFis.ParamByName('ACESSO').AsString := AChaveCtg;
      LqryCadFis.Open;

      If LqryCadFis.IsEmpty Then
      Begin
        strMensagem := 'Chave de acesso "'+ AChaveCtg +'" não encontrada no Livro Fiscal!';
        Exit(False);
      End;

      LqryMovGer.SQL.Add('SELECT "MOVGER" AS TABELA, AUTOINCREM, GER_HORENT');
      LqryMovGer.SQL.Add('FROM MOVGER');
      LqryMovGer.SQL.Add('WHERE GER_NUMDOC = :NUMDOC');
      LqryMovGer.SQL.Add('  AND GER_ESPDOC = :ESPDOC');
      LqryMovGer.SQL.Add('  AND GER_CODEMP = :CODEMP');
      LqryMovGer.SQL.Add('  AND GER_SERIE_ = :SERIE_');
      LqryMovGer.SQL.Add('  AND GER_TIP_FC = :TIP_FC');
      LqryMovGer.SQL.Add('UNION ALL');
      LqryMovGer.SQL.Add('SELECT "NOTGER" AS TABELA, AUTOINCREM, GER_HORENT');
      LqryMovGer.SQL.Add('FROM NOTGER');
      LqryMovGer.SQL.Add('WHERE GER_NUMDOC = :NUMDOC');
      LqryMovGer.SQL.Add('  AND GER_ESPDOC = :ESPDOC');
      LqryMovGer.SQL.Add('  AND GER_CODEMP = :CODEMP');
      LqryMovGer.SQL.Add('  AND GER_SERIE_ = :SERIE_');
      LqryMovGer.SQL.Add('  AND GER_TIP_FC = :TIP_FC');

      LqryMovGer.ParamByName('NUMDOC').AsString := LqryCadFis.FieldByName('FIS_NUMDOC').AsString;
      LqryMovGer.ParamByName('ESPDOC').AsString := LqryCadFis.FieldByName('FIS_ESPDOC').AsString;
      LqryMovGer.ParamByName('CODEMP').AsString := LqryCadFis.FieldByName('FIS_CODEMP').AsString;
      LqryMovGer.ParamByName('SERIE_').AsString := LqryCadFis.FieldByName('FIS_SERIE_').AsString;
      LqryMovGer.ParamByName('TIP_FC').AsString := LqryCadFis.FieldByName('FIS_TIP_FC').AsString;
      LqryMovGer.Open;

      fStartTransaction;

      If LqryMovGer.FieldByName('TABELA').AsString = 'MOVGER' Then
      Begin
        AtualizaTabMov('MOVGER', 'GER_', ADtaEnt, AHorEnt, LqryCadFis);
        AtualizaTabMov('MOVDET', 'DET_', ADtaEnt, AHorEnt, LqryCadFis);
      End
      Else
      Begin
        AtualizaTabMov('NOTGER', 'GER_', ADtaEnt, AHorEnt, LqryCadFis);
        AtualizaTabMov('NOTDET', 'DET_', ADtaEnt, AHorEnt, LqryCadFis);
      End;

      AtualizaCadRec(ADtaEnt, LqryCadFis);
      AtualizaMovCar(ANumPok, ADtaEnt, LqryCadFis);

      LHistorico.Add('Atualização de chave de acesso de nota em contigência.');
      LHistorico.Add('Data/Hora da atualização: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow));
      LHistorico.Add('');
      LHistorico.Add('Chave de acesso anterior: ' + LqryCadFis.FieldByName('FIS_ACESSO').AsString);
      LHistorico.Add('   Chave de acesso atual: ' + AChave);
      LHistorico.Add('');
      LHistorico.Add('Data/Hora anterior: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',
        LqryCadFis.FieldByName('FIS_DTADOC').AsDateTime + LqryMovGer.FieldByName('GER_HORENT').AsDateTime));
      LHistorico.Add('   Data/Hora atual: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', ADtaEnt + AHorEnt));
      LHistorico.Add('----------------------------------------------------------------------');

      LqryCadFis.Edit;
      LqryCadFis.FieldByName('FIS_ACESSO').AsString   := AChave;
      LqryCadFis.FieldByName('FIS_DTAENT').AsDateTime := ADtaEnt;
      LqryCadFis.FieldByName('FIS_DTADOC').AsDateTime := ADtaEnt;
      LqryCadFis.FieldByName('FIS_HISCTG').AsString   := Trim(LqryCadFis.FieldByName('FIS_HISCTG').AsString +
                                                              sLineBreak + LHistorico.Text);
      LqryCadFis.Post;

      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        strMensagem := E.Message;
      End;
    End;
  Finally
    FreeAndNil(LqryCadFis);
    FreeAndNil(LqryMovGer);
    FreeAndNil(LHistorico);
  End;
end;

class function TFaturamentoMercadoLivre.AtualizarDadosNFe(AObjVenda: TFatVenda): Boolean;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  Result := fExecutaSQL(
    ' UPDATE FATMLB ' +
    ' SET MLB_NUMNFE = "' + AObjVenda.strNumDoc + '", ' +
    '     MLB_ESPNFE = "' + AObjVenda.strEspDoc + '", ' +
    '     MLB_SERNFE = "' + AObjVenda.strSerFsc + '", ' +
    '     MLB_CLINFE = "' + AObjVenda.strCodCli + '", ' +
    '     MLB_EMPNFE = "' + AObjVenda.strEmpDoc + '", ' +
    '     MLB_DTANFE = "' + FormatDateTime('yyyy-MM-dd', AObjVenda.dtaDtaEnt) + '", ' +
    '     MLB_TOTNFE = "' + FloatToStr(AObjVenda.fltTotGer).Replace(',', '.') + '"  ' +
    ' WHERE MLB_CHAACE = "' + AObjVenda.strChaveAcesso + '" ');
end;

class function TFaturamentoMercadoLivre.AtualizarDocumentoFinanceiro(AObjVenda: TFatVenda): Boolean;
Var
  LFatMLB: IMyCampoTabela;
  LCadRec: TUniQuery;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  Result    := False;
  LFatMLB   := fCampoTabela(['*'], 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);
  LCadRec   := fCriaQuery();
  Try
    LCadRec.SQL.Text :=
      ' SELECT SQL_NO_CACHE * ' +
      ' FROM CADREC ' +
      ' WHERE TRUE  ' +
      '   AND CTR_NUMDUP = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" ' +
      '   AND CTR_ESPDOC = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" ' +
      '   AND CTR_CODEMP = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" ' +
      '   AND CTR_CODCLI = "' + LFatMLB.FieldByName('MLB_CLIFAT').AsString + '" ' ;
    LCadRec.Open;

    LCadRec.First;
    While (Not LCadRec.Eof) Do
    Begin
      fVerificaIntegridade(Self.ClassName, 'CADREC', LCadRec, True, False,
        'TFaturamentoMercadoLivre.AtualizarDocumentoFinanceiro');
      LCadRec.Next;
    End;

    LCadRec.First;
    While (Not LCadRec.Eof) Do
    Begin
      If LCadRec.FieldByName('CTR_DTAREC').IsNull Then
        Raise Exception.Create('Documento transitório não possui data de baixa - ' +
           '[TFaturamentoMercadoLivre.AtualizarDocumentoFinanceiro]');

      LCadRec.Edit;
      LCadRec.FieldByName('CTR_NUMDUP').AsString   := AObjVenda.strNumDoc;
      LCadRec.FieldByName('CTR_ESPDOC').AsString   := AObjVenda.strEspDoc;
      LCadRec.FieldByName('CTR_CODEMP').AsString   := AObjVenda.strEmpDoc;
      LCadRec.FieldByName('CTR_DTACAD').AsDateTime := AObjVenda.dtaDtaEnt;
      LCadRec.FieldByName('CTR_DTAVEN').AsDateTime := AObjVenda.dtaDtaEnt;
      LCadRec.FieldByName('CTR_DTAREC').AsDateTime := AObjVenda.dtaDtaEnt;
      LCadRec.FieldByName('CTR_DTABAI').AsDateTime := AObjVenda.dtaDtaEnt;
      LCadRec.Post;
      LCadRec.Next;
    End;

    Result := True;

  Finally
    FreeAndNil(LCadRec);
  End;

end;

class function TFaturamentoMercadoLivre.DeletarDocumentoTransitorio(AObjVenda: TFatVenda): Boolean;
const
  ARR_TABELAS_AUXILIAR_MOVGER: Array[0..3] Of Array[0..1] Of String =
    (('AUXMOV','AUX_SEQGER'), ('SERMOV','GER_SEQGER'), ('MOVOBS','MOV_SEQGER'), ('MOVRES','RES_SEQGER'));
const
  ARR_TABELAS_AUXILIAR_MOVDET: Array[0..5] Of Array[0..1] Of String =
    (('MOVTRI','DET_SEQGER'), ('MOVAUX','DET_SEQGER'), ('BRIDET','BRI_SEQDET'), ('MOVICD','ICD_SEQGER'),
     ('MOVITE','ITE_SEQGER'), ('MOVMAD','DET_SEQGER'));
Var
  LFatMLB: IMyCampoTabela;
  LTabGer: TUniQuery;
  LTabDet: TUniQuery;
  LTabAux: TUniQuery;
  LAutInc: String;
  LTabInd: Integer;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  LFatMLB   := fCampoTabela(['*'], 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);
  LTabGer   := fCriaQuery();
  LTabDet   := fCriaQuery();
  LTabAux   := fCriaQuery();
  Try
    LTabGer.Close;
    LTabGer.SQL.Text :=
      ' SELECT SQL_NO_CACHE * ' +
      ' FROM MOVGER ' +
      ' WHERE TRUE  ' +
      '   AND GER_NUMDOC = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" ' +
      '   AND GER_ESPDOC = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" ' +
      '   AND GER_CODEMP = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" ' +
      '   AND GER_CODCLI = "' + LFatMLB.FieldByName('MLB_CLIFAT').AsString + '" ' ;
    LTabGer.Open;

    LTabGer.First;
    While (Not LTabGer.Eof) Do
    Begin
      fVerificaIntegridade(Self.ClassName, 'MOVGER', LTabGer, True, False,
        'TFaturamentoMercadoLivre.DeletarDocumentoTransitorio');

      LAutInc := LTabGer.FieldByName('AUTOINCREM').AsString;

      For LTabInd := Low(ARR_TABELAS_AUXILIAR_MOVGER) To High(ARR_TABELAS_AUXILIAR_MOVGER) Do
      Begin
        LTabAux.Close;
        LTabAux.SQL.Text :=
          ' SELECT SQL_NO_CACHE * FROM ' + ARR_TABELAS_AUXILIAR_MOVGER[LTabInd][0] +
          ' WHERE ' + ARR_TABELAS_AUXILIAR_MOVGER[LTabInd][1] + ' = "' + LAutInc + '" ';
        LTabAux.Open;

        While (Not LTabAux.Eof) Do
        Begin
          fVerificaIntegridade(Self.ClassName, ARR_TABELAS_AUXILIAR_MOVGER[LTabInd][0],
            LTabAux, True, False, 'TFaturamentoMercadoLivre.DeletarDocumentoTransitorio');
          LTabAux.Next;
        End;
      End;

      LTabGer.Next;
    End;

    LTabDet.Close;
    LTabDet.SQL.Text :=
      ' SELECT SQL_NO_CACHE * ' +
      ' FROM MOVDET ' +
      ' WHERE TRUE  ' +
      '   AND DET_NUMDOC = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" ' +
      '   AND DET_ESPDOC = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" ' +
      '   AND DET_CODEMP = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" ' +
      '   AND DET_CODCLI = "' + LFatMLB.FieldByName('MLB_CLIFAT').AsString + '" ' ;
    LTabDet.Open;

    LAutInc := LTabDet.FieldByName('AUTOINCREM').AsString;

    LTabDet.First;
    While (Not LTabDet.Eof) Do
    Begin
      fVerificaIntegridade(Self.ClassName, 'MOVDET', LTabDet, True, False,
        'TFaturamentoMercadoLivre.DeletarDocumentoTransitorio');

      LAutInc := LTabDet.FieldByName('AUTOINCREM').AsString;

      For LTabInd := Low(ARR_TABELAS_AUXILIAR_MOVDET) To High(ARR_TABELAS_AUXILIAR_MOVDET) Do
      Begin
        LTabAux.Close;
        LTabAux.SQL.Text :=
          ' SELECT SQL_NO_CACHE * FROM ' + ARR_TABELAS_AUXILIAR_MOVDET[LTabInd][0] +
          ' WHERE ' + ARR_TABELAS_AUXILIAR_MOVDET[LTabInd][1] + ' = "' + LAutInc + '" ';
        LTabAux.Open;

        While (Not LTabAux.Eof) Do
        Begin
          fVerificaIntegridade(Self.ClassName, ARR_TABELAS_AUXILIAR_MOVDET[LTabInd][0],
            LTabAux, True, False, 'TFaturamentoMercadoLivre.DeletarDocumentoTransitorio');
          LTabAux.Next;
        End;
      End;

      LTabDet.Next;
    End;

    While (Not LTabGer.IsEmpty) Do
      LTabGer.Delete;

    Result := True;

  Finally
    FreeAndNil(LTabGer);
    FreeAndNil(LTabDet);
    FreeAndNil(LTabAux);
  End;

end;

class function TFaturamentoMercadoLivre.FaturarDocumentoTransitorio(AObjVenda: TFatVenda): Boolean;
Var
  LFatMLB: IMyCampoTabela;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  LFatMLB   := fCampoTabela(['*'], 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);

  Result := fExecutaSQL(
    ' UPDATE MOVGER ' +
    ' SET GER_NUMFAT = "' + AObjVenda.strNumDoc + '", ' +
    '     GER_TIPFAT = "' + AObjVenda.strEspDoc + '", ' +
    '     GER_CLIFAT = "' + AObjVenda.strCodCli + '", ' +
    '     GER_EMPFAT = "' + AObjVenda.strEmpDoc + '", ' +
    '     GER_VENFAT = "' + AObjVenda.strCodVen + '", ' +
    '     GER_CNDFAT = "' + AObjVenda.strConPag + '", ' +
    '     GER_VALFAT = "' + FloatToStr(AObjVenda.fltTotGer).Replace(',', '.') + '", ' +
    '     GER_DTAFAT = "' + FormatDateTime('yyyy-MM-dd', AObjVenda.dtaDtaEnt) + '" ' +
    ' WHERE ' +
    '   GER_NUMDOC = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" AND ' +
    '   GER_ESPDOC = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" AND ' +
    '   GER_CODEMP = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" AND ' +
    '   GER_CODCLI = "' + LFatMLB.FieldByName('MLB_CLIFAT').AsString + '" AND ' +
    '   GER_JAFATU = 0 ' );

  Result := Result And fExecutaSQL(
    ' UPDATE MOVDET ' +
    ' SET DET_NUMFAT = "' + AObjVenda.strNumDoc + '", ' +
    '     DET_TIPFAT = "' + AObjVenda.strEspDoc + '", ' +
    '     DET_CLIFAT = "' + AObjVenda.strCodCli + '", ' +
    '     DET_EMPFAT = "' + AObjVenda.strEmpDoc + '", ' +
    '     DET_VENFAT = "' + AObjVenda.strCodVen + '", ' +
    '     DET_CNDFAT = "' + AObjVenda.strConPag + '", ' +
    '     DET_DTAFAT = "' + FormatDateTime('yyyy-MM-dd', AObjVenda.dtaDtaEnt) + '" ' +
    ' WHERE ' +
    '   DET_NUMDOC = "' + LFatMLB.FieldByName('MLB_NUMFAT').AsString + '" AND ' +
    '   DET_ESPDOC = "' + LFatMLB.FieldByName('MLB_TIPFAT').AsString + '" AND ' +
    '   DET_CODEMP = "' + LFatMLB.FieldByName('MLB_EMPFAT').AsString + '" AND ' +
    '   DET_CODCLI = "' + LFatMLB.FieldByName('MLB_CLIFAT').AsString + '" AND ' +
    '   DET_JAFATU = 0 ' );
end;

class function TFaturamentoMercadoLivre.ImportarSomenteNotasFaturadorMLB: Boolean;
begin
  If Not Self.UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  Result := (CfgFulFillment('SOMNFT', MercadoLivrePrefix) <> 'N');
end;

class function TFaturamentoMercadoLivre.NFeAutorizadaFaturador(AChaveAcesso: String): Boolean;
begin
  Result := fCampoTabela('MLB_STATUS', 'FATMLB', ['MLB_CHAACE'], [AChaveAcesso]) = 'AT';
end;

class function TFaturamentoMercadoLivre.NFeEmitidaPeloFaturador(AChaveAcesso, AOrderID: String): Boolean;
Var
  LQuery: TUniQuery;
begin
  Result := False;

  If Not AChaveAcesso.IsEmpty Then
    Result := fCampoTabela('COUNT(0)', 'FATMLB', ['MLB_CHAACE'], [AChaveAcesso]) > 0;

  If Not Result Then
    If Not AOrderID.IsEmpty Then
      Result := fCampoTabela('COUNT(0)', 'FATMLB', ['MLB_NUMPOK'], [AOrderID]) > 0;

  If Not Result Then
    If Not AOrderID.IsEmpty Then
      Result := fCampoTabela('COUNT(0)', 'FATMLB', ['MLB_NUMPOK'], ['MLB_' + AOrderID]) > 0;

  If Not Result Then
    If Not AOrderID.IsEmpty Then
    Begin
      LQuery := fCriaQuery();
      Try
        LQuery.SQL.Text :=
          'SELECT COUNT(0) FROM FATMLB WHERE MLB_NUMPOK LIKE "%' + AOrderID + '%"';
        LQuery.Open;
        Result := LQuery.Fields[0].AsInteger > 0;
      Finally
        FreeAndNil(LQuery);
      End;
    End;
end;

class function TFaturamentoMercadoLivre.NFeSeraEmitidaPeloFaturador(AObjVenda: TFatVenda): Boolean;
begin
  Result := UtilizaFaturadorMercadoLivre() And AObjVenda.strNumPok.StartsWith('MLB_') And AObjVenda.blnExpedi And
    ((AObjVenda.strEspDoc = 'FF') Or (AObjVenda.strTipPed = 'B'));
end;

class function TFaturamentoMercadoLivre.NotaEmitidaAnteriormenteEmContingencia(
  const ANumDoc, AEspDoc, ACodEmp, ASerie, AChave: String;
  out strChaveCtg: String): Boolean;
  Var
    LqryNfeImp: TUniQuery;
begin
  LqryNfeImp := fCriaQuery;
  Try
    LqryNfeImp.SQL.Add('SELECT NFE_ACESSO FROM NFEIMP');
    LqryNfeImp.SQL.Add('JOIN CADFIS ON FIS_ACESSO = NFE_ACESSO');
    LqryNfeImp.SQL.Add('WHERE NFE_NUMDOC = :NUMDOC');
    LqryNfeImp.SQL.Add('  AND NFE_ESPDOC = :ESPDOC');
    LqryNfeImp.SQL.Add('  AND NFE_CODEMP = :CODEMP');
    LqryNfeImp.SQL.Add('  AND NFE_SERIE_ = :SERIE_');
    LqryNfeImp.SQL.Add('  AND NFE_STATUS IN ("AT", "EE")');
    LqryNfeImp.SQL.Add('  AND NFE_ACESSO <> :ACESSO');
    LqryNfeImp.SQL.Add('  AND NFE_TIPEMI > 1 '); //1: emissão normal / 2..9: contingência

    LqryNfeImp.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryNfeImp.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryNfeImp.ParamByName('CODEMP').AsString := ACodEmp;
    LqryNfeImp.ParamByName('SERIE_').AsString := ASerie;
    LqryNfeImp.ParamByName('ACESSO').AsString := AChave;
    LqryNfeImp.Open;

    Result := Not LqryNfeImp.IsEmpty;

    strChaveCtg := LqryNfeImp.FieldByName('NFE_ACESSO').AsString;
  Finally
    FreeAndNil(LqryNfeImp);
  End;
end;

class function TFaturamentoMercadoLivre.RetornaClienteFaturamento(AChaveAcesso: String): String;
begin
  Result := fCampoTabela('MLB_CLIFAT', 'FATMLB', ['MLB_CHAACE'], [AChaveAcesso]);
end;

class function TFaturamentoMercadoLivre.UtilizaFaturadorMercadoLivre: Boolean;
begin
  Result := (CfgFulFillment('FATMLB', MercadoLivrePrefix) = 'S');
end;

class function TFaturamentoMercadoLivre.ValidarClienteNFe(AObjVenda: TFatVenda): Boolean;
Var
  LCliFat: String;
begin
  LCliFat := TFaturamentoMercadoLivre.RetornaClienteFaturamento(AObjVenda.strChaveAcesso);

//  If fRetCgcCpf(LCliFat) <> fRetCgcCpf(AObjVenda.strCodCli) Then
//    Raise Exception.Create('Cliente do documento transitório (' + LCliFat + ') ' +
//      'é diferente do cliente da NFe (' + AObjVenda.strCodCli + ') - ' +
//      '[TFaturamentoMercadoLivre.ValidarClienteNFe]');

  Result := LCliFat.Equals(AObjVenda.strCodCli);
end;

class function TFaturamentoMercadoLivre.ValidarProdutosNFe(AObjVenda: TFatVenda): Boolean;
Var
  LFatMLB: IMyCampoTabela;
  LItem: TDadosFechamento;
  LCodIte: String;
  LSeqGer: String;
  LItensFF: String;
  LItensNF: TStringList;
  LQtdeFF: Double;
  LQtdeNF: Double;
begin
  If Not UtilizaFaturadorMercadoLivre() Then
    Exit(False);

  LFatMLB  := fCampoTabela(['*'], 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);

  LSeqGer := fCampoTabela('DET_SEQGER',
                          'MOVDET',
                         ['DET_NUMDOC','DET_ESPDOC','DET_CODEMP','DET_CODCLI'],
                         [LFatMLB.FieldByName('MLB_NUMFAT').AsString,
                          LFatMLB.FieldByName('MLB_TIPFAT').AsString,
                          LFatMLB.FieldByName('MLB_EMPFAT').AsString,
                          LFatMLB.FieldByName('MLB_CLIFAT').AsString]);

  LItensFF := fCampoTabela('GROUP_CONCAT(DISTINCT DET_CODITE ORDER BY DET_CODITE)', 'MOVDET', ['DET_SEQGER'], [LSeqGer]);

  LItensNF := TStringList.Create;
  Try
    LItensNF.Sorted := True;
    LItensNF.Duplicates := dupIgnore;

    For LItem In AObjVenda.ArrMatItens Do
      LItensNF.Add(LItem.strCodIte);

    Result := LItensFF.Equals(LItensNF.CommaText);

    If Result Then
    Begin
      For LCodIte In LItensNF Do
      Begin
        LQtdeNF := 0;
        For LItem In AObjVenda.ArrMatItens Do
          If LItem.strCodIte.Equals(LCodIte) Then
            LQtdeNF := LQtdeNF + LItem.fltQtdIte;

        LQtdeFF := fCampoTabela('SUM(DET_QTDITE)', 'MOVDET', ['DET_SEQGER', 'DET_CODITE'], [LSeqGer, LCodIte]);

        If fFormataFloat(LQtdeNF, 4) <> fFormataFloat(LQtdeFF, 4) Then
        Begin
          Result := False;
          Break;
        End;
      End;
    End;

  Finally
    FreeAndNil(LItensNF);
  End;
end;

class function TFaturamentoMercadoLivre.ValidarTotalNFe(AObjVenda: TFatVenda): Boolean;
Var
  LTotalFaturado: Double;
begin
  LTotalFaturado := fCampoTabela('MLB_TOTFAT', 'FATMLB', ['MLB_CHAACE'], [AObjVenda.strChaveAcesso]);
  Result := fFormataFloat(LTotalFaturado, 2) = fFormataFloat(AObjVenda.fltTotGer, 2);
end;

end.
