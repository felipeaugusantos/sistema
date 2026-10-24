unit untTDadosEquals;

interface

Uses System.Classes, System.SysUtils, Uni, UniClientDataset;

Type
  TDadosEquals = class
  private
    class function RetornaSQLCamposSimples: String;
  public
    class function RetornaDatasetAdquirinte: TUniClientDataSet;
    class function RetornaDatasetMeiosCaptura: TUniClientDataSet;
  End;

implementation
Uses untFuncoesSImples;


{ TDadosEquals }

class function TDadosEquals.RetornaDatasetAdquirinte: TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := RetornaSQLCamposSimples;
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta, True);
    Result.Open;

    Result.InsertRecord(['1', 'Cielo']);
    Result.InsertRecord(['2', 'Rede']);
    Result.InsertRecord(['3', 'Hipercard']);
    Result.InsertRecord(['4', 'AMEX']);
    Result.InsertRecord(['5', 'Banrisul/Vero']);
    Result.InsertRecord(['6', 'GetNet']);
    Result.InsertRecord(['7', 'Good Card']);
    Result.InsertRecord(['8', 'Elavon']);
    Result.InsertRecord(['9', 'Unik']);
    Result.InsertRecord(['10', 'Cred-System']);
    Result.InsertRecord(['11', 'BradesCard']);
    Result.InsertRecord(['12', 'Sodexo']);
    Result.InsertRecord(['13', 'Sorocred']);
    Result.InsertRecord(['14', 'Calcard']);
    Result.InsertRecord(['15', 'Bin First Data']);
    Result.InsertRecord(['16', 'Aura']);
    Result.InsertRecord(['17', 'Policard']);
    Result.InsertRecord(['18', 'Resomaq']);
    Result.InsertRecord(['19', 'BanPará']);
    Result.InsertRecord(['20', 'Brasilcard-GO']);
    Result.InsertRecord(['21', 'Credishop']);
    Result.InsertRecord(['23', 'Cetelem']);
    Result.InsertRecord(['24', 'Bradesco']);
    Result.InsertRecord(['25', 'Paypal']);
    Result.InsertRecord(['28', 'Verdecard']);
    Result.InsertRecord(['30', 'PagSeguro(Sub)']);
    Result.InsertRecord(['32', 'Ecxcard']);
    Result.InsertRecord(['33', 'DaCasa']);
    Result.InsertRecord(['34', 'Banese']);
    Result.InsertRecord(['35', 'Fortbrasil']);
    Result.InsertRecord(['36', 'Banestes']);
    Result.InsertRecord(['37', 'Itaú']);
    Result.InsertRecord(['38', 'Conductor']);
    Result.InsertRecord(['39', 'Senff']);
    Result.InsertRecord(['40', 'Ibi']);
    Result.InsertRecord(['41', 'Stone']);
    Result.InsertRecord(['42', 'UnidaSul/Suppercard']);
    Result.InsertRecord(['43', 'Caixa']);
    Result.InsertRecord(['44', 'MaxxCard']);
    Result.InsertRecord(['45', 'Bradesco Correspondente']);
    Result.InsertRecord(['46', 'Santander']);
    Result.InsertRecord(['47', 'SOFTNEX']);
    Result.InsertRecord(['48', 'TELENET']);
    Result.InsertRecord(['49', 'CARDBAN']);
    Result.InsertRecord(['50', 'VALECARD - Inativo']);
    Result.InsertRecord(['51', 'CABAL']);
    Result.InsertRecord(['52', 'AVISTA']);
    Result.InsertRecord(['53', 'GRANDCARD']);
    Result.InsertRecord(['54', 'First Data Cono Sur']);
    Result.InsertRecord(['55', 'Visa Argentina']);
    Result.InsertRecord(['56', 'Stelo']);
    Result.InsertRecord(['57', 'Ticket']);
    Result.InsertRecord(['58', 'Losango']);
    Result.InsertRecord(['59', 'Bcash']);
    Result.InsertRecord(['60', 'Itau PL']);
    Result.InsertRecord(['61', 'Pagar.me']);
    Result.InsertRecord(['62', 'Mercado Pago']);
    Result.InsertRecord(['63', 'Coopercard']);
    Result.InsertRecord(['64', 'Adyen']);
    Result.InsertRecord(['65', 'VR Benefícios']);
    Result.InsertRecord(['66', 'Moip']);
    Result.InsertRecord(['67', 'Redetrel']);
    Result.InsertRecord(['68', 'Refeisul']);
    Result.InsertRecord(['69', 'Nutricash']);
    Result.InsertRecord(['70', 'PagSeguro']);
    Result.InsertRecord(['71', 'Transbank']);
    Result.InsertRecord(['72', 'Débito Autorizado Itaú']);
    Result.InsertRecord(['73', 'Débito Autorizado Santander']);
    Result.InsertRecord(['74', 'Débito Autorizado Banco Brasil']);
    Result.InsertRecord(['75', 'Safrapay']);
    Result.InsertRecord(['76', 'Banco do Brasil']);
    Result.InsertRecord(['77', 'Greencard']);
    Result.InsertRecord(['79', 'Valecard']);
    Result.InsertRecord(['80', 'Yalo']);
    Result.InsertRecord(['81', 'Worldpay']);
    Result.InsertRecord(['82', 'SafetyPay']);
    Result.InsertRecord(['83', 'Planvale']);
    Result.InsertRecord(['84', 'B2W']);
    Result.InsertRecord(['86', 'Zoop']);
    Result.InsertRecord(['87', 'Global Payments']);
    Result.InsertRecord(['88', 'Bbpl']);
    Result.InsertRecord(['89', 'Leadercard']);
    Result.InsertRecord(['90', 'Cnova']);
    Result.InsertRecord(['91', 'Ben Visa Vale']);
    Result.InsertRecord(['92', 'Itau débito autorizado']);
    Result.InsertRecord(['93', 'Itau Boleto']);
    Result.InsertRecord(['94', 'Sipag']);
    Result.InsertRecord(['95', 'Sicredi']);
    Result.InsertRecord(['96', 'Vtex']);
    Result.InsertRecord(['97', 'BB CNAB 240']);
    Result.InsertRecord(['98', 'Carrefour PL']);
    Result.InsertRecord(['100', 'Tendência']);
    Result.InsertRecord(['102', 'Magalu Pagamentos']);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TDadosEquals.RetornaDatasetMeiosCaptura: TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := RetornaSQLCamposSimples;
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta, True);
    Result.Open;

    Result.InsertRecord(['1', 'FIXO']);
    Result.InsertRecord(['2', 'GPRS (móvel)']);
    Result.InsertRecord(['3', 'POS/TEF']);
    Result.InsertRecord(['4', 'ADP/BSP']);
    Result.InsertRecord(['5', 'Manual']);
    Result.InsertRecord(['7', 'Mobile']);
    Result.InsertRecord(['8', 'EDI']);
    Result.InsertRecord(['9', 'Outros']);
    Result.InsertRecord(['10', 'Leitor de Trilha']);
    Result.InsertRecord(['11', 'E-Commerce']);
    Result.InsertRecord(['12', 'Micro POS']);
    Result.InsertRecord(['13', 'NFC']);
    Result.InsertRecord(['14', 'URA']);
    Result.InsertRecord(['15', 'EMV']);
    Result.InsertRecord(['16', 'Marketplace']);
    Result.InsertRecord(['17', 'QR Code']);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TDadosEquals.RetornaSQLCamposSimples: String;
begin
  Result := 'SELECT CAST(" " AS CHAR(4)) AS CODIGO, ' +
            '       CAST(" " AS CHAR(150)) AS NOME  ' +
            'FROM DUAL';
end;

end.
