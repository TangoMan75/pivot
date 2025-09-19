import { generateUUID } from '../../src/js/pivot/generate-uuid';

describe('generateUUID', () => {
  it('should generate a valid UUID', () => {
    const uuid = generateUUID();
    expect(uuid).toBeDefined();
    expect(typeof uuid).toBe('string');
    expect(uuid).toMatch(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/);
  });

  it('should generate different UUIDs on multiple calls', () => {
    const uuid1 = generateUUID();
    const uuid2 = generateUUID();
    expect(uuid1).not.toBe(uuid2);
  });

  it('should generate UUIDs with the correct format', () => {
    const uuid = generateUUID();
    const parts = uuid.split('-');
    expect(parts.length).toBe(5);
    expect(parts[0].length).toBe(8);
    expect(parts[1].length).toBe(4);
    expect(parts[2].length).toBe(4);
    expect(parts[3].length).toBe(4);
    expect(parts[4].length).toBe(12);
    expect(parts[2].charAt(0)).toBe('4');
    expect(['8', '9', 'a', 'b'].includes(parts[3].charAt(0))).toBe(true);
  });
});
