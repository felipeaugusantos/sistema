unit untTCuttly;

interface

Uses System.SysUtils, REST.Client, IPPeerClient, IPPeerCommon;

Type
  TRespostaCutty = class
  private
    Fstatus: Integer;
    FfullLink: string;
    Fdate: string;
    FshortLink: string;
    Ftitle: string;
  public
    property status: Integer read Fstatus write Fstatus;
    property fullLink: string read FfullLink write FfullLink;
    property date: string read Fdate write Fdate;
    property shortLink: string read FshortLink write FshortLink;
    property title: string read Ftitle write Ftitle;
  end;

Type
  TObjetoURL = class
  private
    Furl: TRespostaCutty;
  public
    property url: TRespostaCutty read Furl write Furl;
  end;

type
  TCuttly = class
  private
    class function RetiraCaracteresInvalidosDoLinkOriginal(ALinkOriginal: String): String;
  public
    class function EncurtarLinkDoBoleto(ALinkOriginal: String): String;
  end;

implementation
 Uses untFuncoesSimples, REST.Json, System.Json, Classes, untConstantes;
{ TCuttly }

class function TCuttly.EncurtarLinkDoBoleto(ALinkOriginal: String): String;
  Var
    LTokenCuttly: String;

    LResposta: TObjetoURL;

    LClient  : TRestClient;
    LRequest : TRestRequest;
    LResponse: TRestResponse;
begin
  Try
    LTokenCuttly := fCfgSis('CUTKEY');

    Result := ALinkOriginal;

    If LTokenCuttly.IsEmpty Then
      Exit;

    Try
      LClient := TRestClient.Create(Nil);
      LResponse := TRestResponse.Create(Nil);
      LRequest := TRestRequest.Create(Nil);

      LClient.BaseURL := Format('https://cutt.ly/api/api.php?key=%s&short=%s',
                                [LTokenCuttly,
                                 RetiraCaracteresInvalidosDoLinkOriginal(ALinkOriginal)]);
      LClient.HandleRedirects := True;


      LRequest.Client   := LClient;
      LRequest.Response := LResponse;
      LRequest.SynchronizedEvents := False;

      LRequest.Execute;

      LResposta := TJson.JsonToObject<TObjetoURL>(LResponse.Content);

      Result := LResposta.url.shortLink;
    Except
      On E: Exception Do
        Raise Exception.Create('Erro ao encurtar o link: ' + E.Message);
    End;
  Finally
    FreeAndNil(LResponse);
    FreeAndNil(LRequest);
    FreeAndNil(LClient);
  End;

end;

class function TCuttly.RetiraCaracteresInvalidosDoLinkOriginal(
  ALinkOriginal: String): String;
begin
  Result := ALinkOriginal.Replace(#$A, EmptyStr);
end;

end.
