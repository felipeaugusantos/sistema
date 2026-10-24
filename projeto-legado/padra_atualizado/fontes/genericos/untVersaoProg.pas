unit untVersaoProg;

interface

Uses
  SysUtils,
  Forms,
  Controls,
  Dialogs,
  Uni,
  Variants,
  Math;

Type
  TVersaoExecutavel = class
  strict private
    class var FUtilizarVersaoLogAce: String;
    class var FVersaoProduto: String;
    class var FVersaoArquivo: String;
    class procedure RetornarVersao(AConnection: TUniConnection = nil);
    class function VersaoLogAce(strCampo: String; AConnection: TUniConnection = nil): String;
  public
    class function GetVersaoProduto(AConnection: TUniConnection = nil): String;
    class function GetVersaoArquivo: String;
    class function GetTituloVersao: String;
  end;

Type
  TVersao = Record
    strLocArq,
    strNomArq,
    strVerArq,
    strVerPro: String;
    intTamArq: Integer;
    dtaDtaArq,
    horHorArq: TDateTime;
  End;

  TArrVersao = Array Of TVersao;

  TControleVersao = Class (TObject)
  Private

    Function fAtualizaVersaoArquivos: Boolean;

    Procedure pAdicionaArquivo(strPath, strFile: String);

  Public
    arrVerArq: TArrVersao;

    Constructor Create; Reintroduce;
    Destructor Destroy; Override;

  End;


implementation

uses untFuncoesSimples, untConstantes;

Constructor TControleVersao.Create;
  Var
    strPatExe,
    strPatBan: String;
Begin
  inherited;

  If fArqIni(0, 'GERAL', 'VERSAO_LOGACE', 'N') = 'S' Then
    Exit;

  If Not fLock_Unlock('CONTROLE_VERSAO', True, False) Then
    Exit;

  Try
    SetLength(arrVerArq, 0);

    strPatExe := ExtractFilePath(Application.ExeName);
    pAdicionaArquivo(strPatExe, 'AutCom.exe');
    pAdicionaArquivo(strPatExe, 'libRelPedidosDeVenda.dll');
    pAdicionaArquivo(strPatExe, 'libRelBancariosContabeis.dll');
    pAdicionaArquivo(strPatExe, 'libRelChequesPre.dll');
    pAdicionaArquivo(strPatExe, 'libRelContasAReceber.dll');
    pAdicionaArquivo(strPatExe, 'libRelEstatistica.dll');
    pAdicionaArquivo(strPatExe, 'libRelContasAPagar.dll');
    pAdicionaArquivo(strPatExe, 'libRelLivrosFiscais.dll');
    pAdicionaArquivo(strPatExe, 'libRelEstoque.dll');
    pAdicionaArquivo(strPatExe, 'libRelFatGeral.dll');
    pAdicionaArquivo(strPatExe, 'libRelFatEvolucaoVendas.dll');
    pAdicionaArquivo(strPatExe, 'libRelFatMetas.dll');
    pAdicionaArquivo(strPatExe, 'libRelFatComissao.dll');
    pAdicionaArquivo(strPatExe, 'libRelFatVendas.dll');
    pAdicionaArquivo(strPatExe, 'libPedidoDeCompra.dll');
    pAdicionaArquivo(strPatExe, 'libTransfCodigo.dll');
    pAdicionaArquivo(strPatExe, 'libOpeRefProd.dll');
    pAdicionaArquivo(strPatExe, 'libNfe.dll');
    pAdicionaArquivo(strPatExe, 'libFuncoes.dll');
    pAdicionaArquivo(strPatExe, 'libEditorEtiquetas.dll');
    pAdicionaArquivo(strPatExe, 'libReinf.dll');
    pAdicionaArquivo(strPatExe, 'libGatIme.dll');

    If FileExists(strPatExe+'\faturamento.impostos.calculos.bpl') Then
      pAdicionaArquivo(strPatExe, 'faturamento.impostos.calculos.bpl');

    pAdicionaArquivo(ExtractFilePath(Application.ExeName) + '\auttin\', 'AutTin.exe');
    pAdicionaArquivo(ExtractFilePath(Application.ExeName) + '\auttin\', DLL_TINTA_NAME);
    pAdicionaArquivo(ExtractFilePath(Application.ExeName) + '\auttin\', 'Auttin.dll');

    strPatBan := ExtractFilePath(Application.ExeName) + '\autban\';
    pAdicionaArquivo(strPatBan, 'AutBan.exe');

    fAtualizaVersaoArquivos;

    fLock_Unlock('CONTROLE_VERSAO', False, False);
  Except

    On E: Exception Do
    Begin
      fLock_Unlock('CONTROLE_VERSAO', False, False);
      pMensagensErro(E.Message, '[TControleVersao.Create]');
    End;

  End;

End;

Destructor TControleVersao.Destroy;
Begin
  inherited;

  SetLength(arrVerArq, 0);
End;

Procedure TControleVersao.pAdicionaArquivo(strPath, strFile: String);
  Var
    search_rec: TSearchRec;
Begin
  If FindFirst(strPath + strFile, faAnyFile, search_rec) = 0 Then
  Begin
    repeat

      If search_rec.Attr <> faDirectory Then
      Begin
        SetLength(arrVerArq, Succ(Length(arrVerArq)));

        With arrVerArq[High(arrVerArq)] Do
        Begin
          strLocArq := strPath;
          strNomArq := strFile;

          If Pos('AutCom', strFile) > 0 Then
          Begin
            strVerArq := TVersaoExecutavel.GetVersaoArquivo;
            strVerPro := TVersaoExecutavel.GetVersaoProduto;
          End
          Else
          Begin
            strVerArq := '';
            strVerPro := '';
          End;

          intTamArq := search_rec.Size;
          dtaDtaArq := StrToDate(FormatDateTime('dd/mm/yyyy', search_rec.TimeStamp));
          horHorArq := StrToTime(FormatDateTime('hh:mm:ss', search_rec.TimeStamp));
        End;

      End;

    until FindNext(search_rec) <> 0;

    FindClose(search_rec);
  End;

End;

Function TControleVersao.fAtualizaVersaoArquivos: Boolean;
  Var
    qryVersao: TUniQuery;
    intIndice: Integer;
Begin

  Result := False;

  Try

    qryVersao := fCriaQuery;

    With qryVersao, SQL Do
    Begin
      Clear;
      Add('SELECT LOWER(INF_NOMARQ) NOMARQ, INFSIS.* FROM INFSIS');
      Open;

      For intIndice := Low(arrVerArq) To High(arrVerArq) Do
      With arrVerArq[intIndice] Do
      Begin
        If Locate('NOMARQ', LowerCase(strNomArq), []) Then
          Edit
        Else
          qryVersao.Insert;

        FieldByName('INF_NOMARQ').AsString   := strNomArq;
        FieldByName('INF_VERARQ').AsString   := strVerArq;
        FieldByName('INF_VERPRO').AsString   := strVerPro;

        FieldByName('INF_DTAARQ').AsDateTime := dtaDtaArq;
        FieldByName('INF_HORARQ').AsDateTime := horHorArq;

        FieldByName('INF_TAMARQ').AsInteger  := intTamArq;        

        If FieldByName('INF_DTAARQ').AsDateTime = 0 Then
        Begin
          FieldByName('INF_DTAARQ').Clear;
          FieldByName('INF_HORARQ').Clear;
        End;

        Post;
      End;
    End;

    Result := True;

  Except

    On E: Exception Do
    Begin
      //Manter mudo para não gerar registro na LOGERR

    End;

  End;

  FreeAndNil(qryVersao);
End;

{ TVersaoExecutavel }

class function TVersaoExecutavel.GetTituloVersao: String;
{$I rev.inc}
Var
  LVersao: String;
  LBuild: String;
begin
  Try
    LVersao := TVersaoExecutavel.GetVersaoArquivo.Split(['.'])[0] + '.' +
               TVersaoExecutavel.GetVersaoProduto.Split(['.'])[0] + '.' +
               TVersaoExecutavel.GetVersaoProduto.Split(['.'])[1] + '.' +
               TVersaoExecutavel.GetVersaoProduto.Split(['.'])[2] ;

    LBuild := TVersaoExecutavel.GetVersaoProduto.Split(['.'])[3];

    Result := 'Autcom V. ' + LVersao + '.' + LBuild + ' [ ' + SVN_REVISION + ' ]';
  Except
    Result := '';
  End;
end;

class function TVersaoExecutavel.GetVersaoArquivo: String;
begin
  RetornarVersao;
  Result := FVersaoArquivo;
end;

class function TVersaoExecutavel.GetVersaoProduto(AConnection: TUniConnection = nil): String;
begin
  RetornarVersao(AConnection);
  Result := FVersaoProduto;
end;

class procedure TVersaoExecutavel.RetornarVersao(AConnection: TUniConnection = nil);
begin
  If FUtilizarVersaoLogAce.IsEmpty Then
    FUtilizarVersaoLogAce := fArqIni(0, 'GERAL', 'VERSAO_LOGACE', 'N');

  If FUtilizarVersaoLogAce = 'S' Then
  Begin
    If FVersaoArquivo.IsEmpty Then
      FVersaoArquivo := VersaoLogAce('LOG_VEREXE', AConnection);
    If FVersaoProduto.IsEmpty Then
      FVersaoProduto := VersaoLogAce('LOG_VERPRO', AConnection);
  End;

  If FVersaoArquivo.IsEmpty Then
    FVersaoArquivo := fRetornaVersao(Application.ExeName);
  If FVersaoProduto.IsEmpty Then
    FVersaoProduto := fRetornaVersao(Application.ExeName, True);
end;

class function TVersaoExecutavel.VersaoLogAce(strCampo: String; AConnection: TUniConnection = nil): String;
Var
  LFileAge: TDateTime;
  LPathExe: String;
  LExeName: String;
  LQryLog : TUniQuery;
begin
  LQryLog := fCriaQuery(nil, AConnection);
  Try
    FileAge(Application.ExeName, LFileAge);
    LFileAge := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss', LFileAge));

    LPathExe := ExtractFilePath(Application.ExeName);
    LExeName := ExtractFileName(Application.ExeName);

    LQryLog.SQL.Clear;
    LQryLog.SQL.Add(' SELECT ' + strCampo);
    LQryLog.SQL.Add(' FROM ');
    LQryLog.SQL.Add('   LOGACE ');
    LQryLog.SQL.Add(' WHERE LOG_DTAENT = :DTAENT ');
    LQryLog.SQL.Add('   AND LOG_DTAEXE = :DTAEXE ');
    LQryLog.SQL.Add('   AND LOG_PATEXE = :PATEXE ');
    LQryLog.SQL.Add('   AND LOG_NOMEXE = :NOMEXE ');
    LQryLog.SQL.Add(' LIMIT 1 ');

    LQryLog.ParamByName('DTAENT').AsDateTime := Date();
    LQryLog.ParamByName('DTAEXE').AsDateTime := LFileAge;
    LQryLog.ParamByName('PATEXE').AsString   := LPathExe;
    LQryLog.ParamByName('NOMEXE').AsString   := LExeName;

    LQryLog.Open;

    Result := LQryLog.FieldByName(strCampo).AsString;
  Finally
    LQryLog.Free;
  End;
end;

end.
