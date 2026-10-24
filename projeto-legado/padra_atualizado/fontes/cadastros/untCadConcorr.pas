unit untCadConcorr;

interface

uses Classes, DB, Uni, untFuncoesSimples;

type
  TCadConcorr = Class(TComponent)
    private
      FAutInc: String;
      FCodCon: String;
      FDesCon: string;

      procedure setCodCon(const Value: String);
      procedure setDesCon(const Value: String);
    public
      qryTabela: TUniQuery;
      arrDefCam: TArrDefCam;

      property strCodCon: String read FCodCon write setCodCon;
      property strDesCon: String read FDesCon write setDesCon;

      Constructor Create(Owner: TComponent); Reintroduce;
  End;

Const
  arrCampos   : Array[0..2] of String     = ('AUTOINCREM', 'CNR_CODCON', 'CNR_DESCON');
  arrDescricao: Array[0..2] of String     = ('AUTOINCREM', 'Código', 'Descrição');
  arrTipo     : Array[0..2] of TFieldType = (ftString, ftString, ftString);
  arrTamanho  : Array[0..2] of integer    = (20, 5, 70);
  arrVisible  : Array[0..2] of Boolean    = (True, True, False);
  arrFormat   : Array[0..2] of String     = ('', '', '');

implementation

{ TCadConcorr }

uses SysUtils;

constructor TCadConcorr.Create(Owner: TComponent);
var
  intContador: integer;
begin
  try
    SetLength(arrDefCam, 3);

    for intContador := Low(arrDefCam) to High(arrDefCam) do
    begin
      arrDefCam[intContador].strNomCam  := arrCampos[intContador];
      arrDefCam[intContador].strDesCri  := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam  := arrTipo[intContador];
      arrDefCam[intContador].intTamCam  := arrTamanho[intContador];
      arrDefCam[intContador].blnVisible := arrVisible[intContador];
      arrDefCam[intContador].strFormat  := arrFormat[intContador];
    end;

    qryTabela := fCriaQuery(Self);

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADCNR WHERE FALSE');
    qryTabela.Open;

    FAutInc := '';
    FCodCon := '';
    FDesCon := '';
  except
    on E: Exception do
      raise Exception.Create('Ocorreu um erro ao criar o objeto TCadConcorr!' + sLineBreak + E.Message);
  end;
end;

procedure TCadConcorr.setCodCon(const Value: String);
begin
  if (not fEmptyStr(Value)) then
  begin
    FCodCon := Value;
  end
  else
  begin
    raise Exception.Create('O código do concorrênte deve ser preenchido!');
  end;
end;

procedure TCadConcorr.setDesCon(const Value: String);
begin
  if (not fEmptyStr(Value)) then
  begin
    FDesCon := Value;
  end
  else
  begin
    raise Exception.Create('A descrição do concorrênte deve ser preenchido!');
  end;
end;

end.
