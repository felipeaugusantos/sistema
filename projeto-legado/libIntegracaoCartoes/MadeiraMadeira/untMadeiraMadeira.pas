{***********************************************************}
{* Importação de arquivos com RESTClient da MadeiraMadeira *}
{***********************************************************}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{*******************************************}
unit untMadeiraMadeira;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Vcl.Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, cxCalendar, IPPeerClient, DateUtils, System.Generics.Collections,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Json, REST.Authenticator.Basic;

Type
  TChavesMadeiraMadeira = class
  private
  public
    CodEmpresa,
    UrlBase,
    Token : String;
  end;

Type
  TMadeiraMadeira = Class(TComponent)
  Private
    frmForm   : TForm;
    pgbProg   : TProgressBar;
    edtDtaIni : TcxDateEdit;
    edtDtaFin : TcxDateEdit;
    memXMLDoc : TMemo;
    lblInform : TLabel;
    pnlFund   : TPanel;

    FAplicacao: HWND;

    FListaChaves: TList<TChavesMadeiraMadeira>;

    procedure pDisableControls(const blnDisable: Boolean);
    procedure btnConfClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function fRetUltimaData: String;

    function RetornaListaDeChavesMadeiraMadeira: TList<TChavesMadeiraMadeira>;

    procedure CriarComponentesRequisicao;
    procedure ProcessaDownload;
    procedure DownloadDataSelecionada(const AChaveSelecionada: TChavesMadeiraMadeira;
                                      const ADataImportacao: TDateTime;
                                      const AOffSet: Integer);
    procedure OnAfterExecute(Sender: TCustomRESTRequest);
    procedure DestroiComponentesRequisicao;
  Public
    property Aplicacao: HWND read FAplicacao write FAplicacao;
    procedure pSelecionaFonte;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  protected
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;
    FChavesMadeiraMadeira: TStringList;
  End;

implementation

uses untFuncoes, untIDataSet, untMadeiraMadeiraPgto;

{ TMadeiraMadeira }

constructor TMadeiraMadeira.Create(Owner: TComponent);
begin
  inherited;
  FListaChaves := RetornaListaDeChavesMadeiraMadeira;
end;

procedure TMadeiraMadeira.CriarComponentesRequisicao;
begin
  FRestClient := TRestClient.Create(Nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.HandleRedirects := True;
  FRestClient.SynchronizedEvents := True;

  FRestResponse := TRestResponse.Create(Nil);

  FRestRequest := TRestRequest.Create(Nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Method := rmGet;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute := OnAfterExecute;

  FRestRequest.Params.AddHeader('Content-Type', 'application/json');
  FRestRequest.Params.AddHeader('TOKENMM', '');
  FRestRequest.Params[0].Kind := pkHTTPHEADER;
  FRestRequest.Params[0].Options := [poDoNotEncode];
  FRestRequest.Params[1].Kind := pkHTTPHEADER;
  FRestRequest.Params[1].Options := [poDoNotEncode];
end;

destructor TMadeiraMadeira.Destroy;
begin
  inherited;
  FreeAndNil(FListaChaves);
  DestroiComponentesRequisicao;
end;

procedure TMadeiraMadeira.DestroiComponentesRequisicao;
begin
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestClient);
end;

procedure TMadeiraMadeira.DownloadDataSelecionada(const AChaveSelecionada: TChavesMadeiraMadeira;
                                                  const ADataImportacao: TDateTime;
                                                  const AOffSet: Integer);
  Var
    LContador: Integer;
    LAutorizado: Boolean;
    LMensagem: String;
    LResposta: String;
Begin
  LAutorizado := False;
  LContador := 0;

  Try
    CriarComponentesRequisicao;

    FRestRequest.Params[1].Value := AChaveSelecionada.Token;

    While (LContador <= 3) And (Not LAutorizado) Do
    Begin
      Try
        FRestClient.BaseUrl := AChaveSelecionada.UrlBase
          + 'date_from=' + FormatDateTime('yyyy-mm-dd', ADataImportacao)
          + '&date_to=' + FormatDateTime('yyyy-mm-dd', ADataImportacao)
          + '&limit=100&offset=' + AOffSet.ToString;

        FRestRequest.Execute;

        If FRestResponse.StatusCode = 404 Then
          break;

        If FRestResponse.StatusCode <> 200 Then
          Raise Exception.Create(FRestResponse.Content);

        memXMLDoc.Lines.Clear;
        memXMLDoc.Text := FRestResponse.Content;

        LAutorizado := True;
      Except
        On E: Exception Do
        Begin
          LAutorizado := FRestResponse.StatusCode <> 401;

          if FRestResponse.StatusCode = 400 Then
          Begin
            Raise Exception.Create('Requisição incorreta. ' + AChaveSelecionada.CodEmpresa + '.');
          End
          Else If FRestResponse.StatusCode = 401 Then
          Begin
            If LContador <= 4 Then
            Begin
              Inc(LContador);
              lblInform.Caption := 'Revalidando chaves de autorização para a empresa ' + AChaveSelecionada.CodEmpresa + '.';
            End
            Else
              Raise Exception.Create('Chaves de autorização, Token incorreto ou não liberado para importação!' + #13 +
                                     'Empresa: ' +  AChaveSelecionada.CodEmpresa + #13 +
                                     'Erro código 401.');
          End
          Else
          Begin
            LAutorizado := False;

            If LContador <= 4 Then
            Begin
              Inc(LContador);
              lblInform.Caption := 'Erro ao realizar a importação. Nova tentativa após 5 segundos.';
              Application.ProcessMessages;

              Sleep(5000);
            End
            Else
            Begin
              LMensagem := 'Em momentos de pico de requisições, podem causar instabilidades no serviço.';

              If MatchStr(FRestResponse.StatusCode.ToString, ['502', '503']) Then
                Raise Exception.Create('O serviço da MadeiraMadeira está com problemas no funcionamento. Tente novamente mais tarde!' + #13 +
                                       LMensagem + #13 +
                                       'Erro código 503.')
              Else If FRestResponse.StatusCode = 500 Then
                Raise Exception.Create('Ocorreu um erro interno no serviço da MadeiraMadeira. ' + LMensagem + #13 +
                                       'Tente novamente mais tarde!' + #13 +
                                       'Erro código ' + FRestResponse.StatusCode.ToString + '.')
              Else If FRestResponse.StatusCode = 0 Then
                Raise Exception.Create('Ocorreu um erro ao realizar a importação: 0 - ' + E.Message)
              Else
                Raise Exception.Create('Ocorreu um erro ao conectar-se ao serviço da MadeiraMadeira. ' + LMensagem + #13 +
                                       'Tente novamente mais tarde!' + #13 +
                                       'Código do erro: ' + FRestResponse.StatusCode.ToString + '-' +
                                                            LResposta);
            End;
          End;

          If LContador > 0 Then
          Begin
            lblInform.Caption := 'Aguarde... Nova tentativa de download do dia ' + FormatDateTime('dd/mm/yyyy', ADataImportacao) +
                                 ' da Empresa ' + AChaveSelecionada.CodEmpresa;
            Application.ProcessMessages;
          End;
        End;
      End;
    End;
  Finally
    DestroiComponentesRequisicao;
  End;
end;

procedure TMadeiraMadeira.FormOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
    TForm(Sender).Perform(40,0,0);
end;

function TMadeiraMadeira.fRetUltimaData: String;
  Var
    qryDados: IDataSet;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.SQL := 'SELECT MAX(MAD_DTALAN) AS MAD_DATA FROM MAD_APPGTO';
  qryDados.Open;
  If qryDados.FieldByName('MAD_DATA').AsString <> '' Then
    Result := qryDados.FieldByName('MAD_DATA').AsString
  Else
    Result := 'Nenhuma';
end;

procedure TMadeiraMadeira.btnSairClick(Sender: TObject);
Begin
  frmForm.Close;
End;

procedure TMadeiraMadeira.btnConfClick(Sender: TObject);
Begin
  If (edtDtaIni.Date >= Date) Or (edtDtaFin.Date >= Date) Then
  Begin
    objFunctions.fIMensagem('','As datas para importação não podem ser maiores ou iguais a data atual!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date = 0) Or (edtDtaFin.Date = 0) Then
  Begin
    objFunctions.fIMensagem('','É necessário digitar a data inicial e a data final!',['&OK']);
    Exit;
  End;
  If (edtDtaIni.Date > edtDtaFin.Date) Then
  Begin
    objFunctions.fIMensagem('','A data inicial deve ser menor que data final!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 10 Then
  Begin
    objFunctions.fIMensagem('ATENÇÃO','A quantidade de dias do período não pode ser maior que 10!',['&OK']);
    Exit;
  End;
  If (edtDtaFin.Date - edtDtaIni.Date) > 5 Then
  Begin
    If objFunctions.fIMensagem('','A quantidade de dias do período é maior 5 dias. ' +
                                  'A importação da MadeiraMadeira é feita através da Internet, dependendo da quantidade ' +
                                  'de registros a operação pode demorar. Deseja realmente continuar?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  pDisableControls(True);
  ProcessaDownload;
  pDisableControls(False);
End;

procedure TMadeiraMadeira.ProcessaDownload;
  Var
    LDataSelecionada: TDate;

    LiCartoes: TMadeiraMadeiraPgto;

    LMensagem: String;

    LChavesMadeiraMadeira: TChavesMadeiraMadeira;

    LContador: Integer;

    LOcorreuErro,
    LPararNoErro: Boolean;
    LOffSet: Integer;
begin
  Try
    pValidaLibsWebService;

    LiCartoes := TMadeiraMadeiraPgto.Create;

    If FListaChaves.Count = 0 Then
    Begin
      objFunctions.fIMensagem('','Não existem empresas configuradas com o Token de Autorização da MadeiraMadeira. Operação cancelada!',['&OK']);
      Exit;
    End;

    LOcorreuErro := False;
    LPararNoErro := False;

    //Correndo os dias para efetuar o download
    LDataSelecionada := edtDtaIni.Date;
    While (LDataSelecionada <= edtDtaFin.Date) Do
    Begin
      LContador := 0;
      LOffSet := 0;

      For LChavesMadeiraMadeira In FListaChaves Do
      Begin
        SetLength(FRegMadeiraMadeiraPgto, 0);
        Inc(LContador);

        lblInform.Caption := 'Aguarde... Efetuando o download do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                            ' da Empresa ' + LChavesMadeiraMadeira.CodEmpresa;
        Application.ProcessMessages;

        Try
          While True Do
            Begin
              DownloadDataSelecionada(LChavesMadeiraMadeira, LDataSelecionada, LOffSet);

              LiCartoes.pSetCodigoEmpresa(LChavesMadeiraMadeira.CodEmpresa);
              LiCartoes.pSetOffSet(LOffSet);
              LiCartoes.pAdicionaLinha(memXMLDoc.Text);
              If LiCartoes.fGetOffSet <> LOffSet Then
                Begin
                 LOffSet := LiCartoes.fGetOffSet;
                 continue;
                end;

              lblInform.Caption := 'Aguarde... Gravando os lançamentos do dia ' + FormatDateTime('dd/mm/yyyy', LDataSelecionada) +
                                  ' da Empresa ' + LChavesMadeiraMadeira.CodEmpresa;
              Application.ProcessMessages;

              LiCartoes.pGravarRegistros(pgbProg);

              Application.ProcessMessages;

              break;
            End;
        Except
          On E: Exception Do
          Begin
            LOcorreuErro := True;

            If (LContador = FListaChaves.Count) And (LDataSelecionada = edtDtaFin.Date) Then
              objFunctions.fIMensagem('ERRO', E.Message, ['&OK'])
            Else
              LPararNoErro := objFunctions.fIMensagem('ERRO', E.Message + #13 +
                                                      'Deseja continuar com a importação das outras datas/empresas?',
                                                      ['&Sim', 'Não']) = 2;
          End;
        End;

        If LPararNoErro Then
          Break;
      End;

      If LPararNoErro Then
        Break;

      LDataSelecionada := IncDay(LDataSelecionada, 1);
    End;

    LMensagem := 'Nenhum registro foi importado no período selecionado!';
    If TMadeiraMadeiraPgto(LiCartoes).ImportouRegistro Then
    Begin
      If Not LOcorreuErro Then
      Begin
        LMensagem := 'Dados importados com sucesso!';
      End
      Else
        LMensagem := 'Registros foram importados, porém ocorreu algum erro durante a importação.';
    End;
    objFunctions.fIMensagem('ATENÇÃO', LMensagem,['&OK']);

  Finally
    pDisableControls(False);
  End;

  frmForm.Close;
end;

procedure TMadeiraMadeira.pDisableControls(const blnDisable: Boolean);
begin
  pnlFund.Enabled    := not blnDisable;
  edtDtaIni.Enabled  := not blnDisable;
  edtDtaFin.Enabled  := not blnDisable;
end;

procedure TMadeiraMadeira.pSelecionaFonte;
  Var
    lblDtaIni,
    lblDtaFin: TLabel;
    btnSair  : TBitBtnLocked;
    btnConf  : TBitBtnLocked;
Begin

  frmForm := TForm.Create(Self);
  With frmForm Do
  Begin
    BorderStyle  := bsSingle;
    Caption      := 'Importação de Registros (MadeiraMadeira API)';
    ClientHeight := 102;
    ClientWidth  := 402;
    Color        := 16770261;
    Position     := poScreenCenter;
    BorderIcons  := [biSystemMenu];
    KeyPreview   := True;
    OnKeyDown    := FormOnKeyDown;
    Icon.LoadFromResourceName(HInstance, 'AUTCOM1');  //utilizando recurso para adicionar o icone AJ
  End;

  lblDtaIni := TLabel.Create(frmForm);
  With lblDtaIni Do
  Begin
    Parent   := frmForm;
    Top      := 12;
    AutoSize := True;
    Caption  := 'Data Inicial:';
    Left     := Round(frmForm.Width / 2) - Width - 95 - 5;
  End;

  edtDtaIni := TcxDateEdit.Create(frmForm);
  With edtDtaIni Do
  Begin
    Parent   := frmForm;
    Left     := lblDtaIni.Left + lblDtaIni.Width + 2;
    Top      := 8;
    Height   := 21;
    TabOrder := 0;
    Width    := 90;
    Text     := DateToStr(Yesterday);
   //DELPHI 2007
   {$IF Defined(VER185) Or Defined(VER180)}
    Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
   {$ELSE}
    Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
   {$ENDIF}
  End;

  lblDtaFin := TLabel.Create(frmForm);
  With lblDtaFin Do
  Begin
    Parent   := frmForm;
    Left     := edtDtaIni.Left + edtDtaIni.Width + 15 + 5;
    Top      := 12;
    AutoSize := True;
    Caption  := 'Data Final:';
  End;

  edtDtaFin := TcxDateEdit.Create(frmForm);
  With edtDtaFin Do
  Begin
    Parent   := frmForm;
    Left     := lblDtaFin.Left + lblDtaFin.Width + 2;
    Top      := 8;
    Height   := 21;
    TabOrder := 1;
    Width    := 90;
    Text     := DateToStr(Yesterday);
   //DELPHI 2007 
   {$IF Defined(VER185) Or Defined(VER180)}
    Properties.ButtonGlyph.LoadFromResourceName(HInstance, 'CALENDARIO');
   {$ELSE}
    Properties.ButtonGlyph.LoadFromResource(HInstance, 'CALENDARIO', RT_BITMAP);
   {$ENDIF}
  End;

  lblInform := TLabel.Create(frmForm);
  With lblInform Do
  Begin
    Parent   := frmForm;
    Left     := 0;
    Top      := 42;
    AutoSize := False;
    Width    := frmForm.Width;
    Alignment:= taCenter;
    Caption  := 'Digite o período para realizar a importação. Última data importada: ' + fRetUltimaData;
  End;

  memXMLDoc := TMemo.Create(frmForm);
  With memXMLDoc Do
  Begin
    Parent   := frmForm;
    Left     := 8;
    Top      := 42;
    Visible  := False;
  End;

  pnlFund := TPanel.Create(frmForm);
  With pnlFund Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 28;
    Color    := clGray;
    TabOrder := 2;
  End;

  pgbProg := TProgressBar.Create(frmForm);
  With pgbProg Do
  Begin
    Parent   := frmForm;
    Align    := alBottom;
    Height   := 10;
    Position := 0;
  End;

  btnSair := TBitBtnLocked.Create(frmForm);
  With btnSair Do
  Begin
    Parent   := pnlFund;
    Left     := 327;
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 1;
    OnClick  := btnSairClick;
    Kind     := bkClose;
    Caption  := '&Sair';
    Cancel   := True;
    Glyph    := TBitmap.Create;
  End;

  btnConf := TBitBtnLocked.Create(frmForm);
  With btnConf Do
  Begin
    Parent   := pnlFund;
    Left     := 4;
    Top      := 2;
    Width    := 72;
    Height   := 24;
    TabOrder := 0;
    OnClick  := btnConfClick;
    Default  := False;
    Caption  := '&Importar';
    Glyph    := TBitmap.Create;
  End;

  frmForm.ShowModal;

  FreeAndNil(frmForm);
End;

function TMadeiraMadeira.RetornaListaDeChavesMadeiraMadeira: TList<TChavesMadeiraMadeira>;
  Var
    LDados: IDataset;
    LChavesMadeiraMadeira: TChavesMadeiraMadeira;
    LToken: String;
begin
  Result := TList<TChavesMadeiraMadeira>.Create;

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := 'SELECT SIS_VALCFG, SIS_CODEMP FROM CFGSIS    ' +
                ' WHERE SIS_CODCFG="CFG_MADTKN" AND           ' +
                ' SIS_VALCFG IS NOT NULL AND SIS_VALCFG <> "" ' +
                ' ORDER BY SIS_CODEMP                         ';
  LDados.Open;

  While Not LDados.Eof Do
  Begin
    LToken := fRetornaValorConfiguracao('CFG_MADTKN', LDados.FieldByName('SIS_CODEMP').AsString);
    If Not LToken.IsEmpty Then
    Begin
      LChavesMadeiraMadeira := TChavesMadeiraMadeira.Create;
      LChavesMadeiraMadeira.CodEmpresa := LDados.FieldByName('SIS_CODEMP').AsString;
      LChavesMadeiraMadeira.Token := LToken;
      LChavesMadeiraMadeira.UrlBase := fRetornaValorConfiguracao('CFG_MADLNK', LDados.FieldByName('SIS_CODEMP').AsString);
      Result.Add(LChavesMadeiraMadeira);
    End;
    LDados.Next;
  End;
end;

procedure TMadeiraMadeira.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

end.
